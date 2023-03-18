import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:convenient_way_sender/app/core/base/base_controller.dart';
import 'package:convenient_way_sender/app/core/services/background_service_notification.dart';
import 'package:convenient_way_sender/app/core/services/firebase_messaging_service.dart';
import 'package:convenient_way_sender/app/core/utils/material_dialog_service.dart';
import 'package:convenient_way_sender/app/core/utils/toast_service.dart';
import 'package:convenient_way_sender/app/core/widgets/custom_overlay.dart';
import 'package:convenient_way_sender/app/data/constants/prefs_memory.dart';
import 'package:convenient_way_sender/app/data/constants/user_config_name.dart';
import 'package:convenient_way_sender/app/data/local/preference/preference_manager.dart';
import 'package:convenient_way_sender/app/data/models/account_model.dart';
import 'package:convenient_way_sender/app/data/models/balance_model.dart';
import 'package:convenient_way_sender/app/data/models/user_config_model.dart';
import 'package:convenient_way_sender/app/data/repository/account_req.dart';
import 'package:convenient_way_sender/app/data/repository/request_model/login_model.dart';
import 'package:convenient_way_sender/app/data/repository/request_model/logout_model.dart';
import 'package:convenient_way_sender/app/data/repository/response_model/authorize_response_model.dart';
import 'package:convenient_way_sender/app/network/exceptions/base_exception.dart';
import 'package:convenient_way_sender/app/routes/app_pages.dart';

class AuthController extends BaseController {
  final RxBool _isReload = false.obs;
  final RxBool _isLoadingConfig = false.obs;

  final AccountRep _accountRepo = Get.find(tag: (AccountRep).toString());
  final PreferenceManager prefs = Get.find(tag: (PreferenceManager).toString());

  String? _token;
  final Rx<Account?> _account = Rx<Account?>(null);
  final Rx<BalanceModel?> _balanceAvailable = Rx<BalanceModel?>(null);
  final RxBool _isLoadingAvailableBalance = false.obs;
  final RxList<UserConfig> configs = RxList<UserConfig>([]);

  Account? get account => _account.value;
  int get availableBalance => _balanceAvailable.value?.balance ?? 0;
  bool get isNewAccount => _balanceAvailable.value?.isNewAccount ?? false;
  bool get isLoadingAvailableBalance => _isLoadingAvailableBalance.value;
  set setAccount(Account value) {
    _account.value = value;
  }

  bool get isReload => _isReload.value;

  int? get warningPriceConfig => int.parse(configs
          .firstWhereOrNull(
              (element) => element.name == UserConfigName.WARNING_PRICE)
          ?.value ??
      '0');
  bool? get isActiveConfig =>
      configs
          .firstWhereOrNull(
              (element) => element.name == UserConfigName.IS_ACTIVE)
          ?.value ==
      'TRUE';
  String? get directionSuggestConfig => configs
      .firstWhereOrNull(
          (element) => element.name == UserConfigName.DIRECTION_SUGGEST)
      ?.value;
  int? get packageDistanceConfig => int.parse(configs
          .firstWhereOrNull(
              (element) => element.name == UserConfigName.PACKAGE_DISTANCE)
          ?.value ??
      '0');

  String? get token {
    if (!isTokenValidDateTime(_token)) {
      return null;
    }
    return _token;
  }

  bool isTokenValidDateTime(String? token) {
    if (token == null) return false;
    Map<String, dynamic> payload = Jwt.parseJwt(_token.toString());
    DateTime? exp = DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
    if (exp.compareTo(DateTime.now()) <= 0) {
      return false;
    }
    return true;
  }

  Future<String?> getKeyToken(String key) async {
    String? result;
    String token = await prefs.getString(PrefsMemory.token);
    if (token.isNotEmpty) {
      Map<String, dynamic> payload = Jwt.parseJwt(token.toString());
      result = payload[key];
    }
    return result;
  }

  Future<void> reloadAccount() async {
    if (_account.value != null) {
      var accountService = _accountRepo.getAccountId(_account.value!.id!);
      await callDataService<Account?>(accountService,
          onSuccess: (Account? response) async {
            _account.value = response;
            PreferenceManager prefs =
                Get.find(tag: (PreferenceManager).toString());
            prefs.setString(PrefsMemory.userJson, jsonEncode(response));
            loadBalance();
            loadConfigs();
            // BackgroundNotificationService.initializeService();
          },
          onError: (exception) {
            if (exception is BaseException) {
              ToastService.showError((exception).message);
            }
          },
          onStart: () => _isReload.value = true,
          onComplete: () => _isReload.value = false);
    }
  }

  Future<bool> login(LoginModel model,
      {Function? onStart, Function? onComplete}) async {
    bool result = false;
    try {
      String? token;
      var loginService = _accountRepo.login(model);
      await callDataService(loginService,
          onSuccess: (AuthorizeResponseModel response) async {
        token = response.token;
        _account.value = response.account;
        PreferenceManager prefs = Get.find(tag: (PreferenceManager).toString());
        prefs.setString(PrefsMemory.token, token!);
        prefs.setString(PrefsMemory.userJson, jsonEncode(response.account));

        // await BackgroundNotificationService.initializeService();
        await FirebaseMessagingService.registerNotification(
            _account.value!.id!);
        loadBalance();
        loadConfigs();
      }, onError: (exception) {
        if (exception is BaseException) {
          ToastService.showError((exception).message);
        }
      }, onStart: onStart, onComplete: onComplete);

      if (token != null) {
        _token = token;
        result = true;
        Get.offAndToNamed(Routes.HOME);
        // if (_account.value?.status == "NO_ROUTE") {
        //   Get.offAndToNamed(Routes.CREATE_ROUTE);
        // } else {
        //   Get.offAndToNamed(Routes.HOME);
        // }
      }
    } catch (e) {
      debugPrint('Unable to connect');
    }
    return result;
  }

  void setDataPrefs() {
    PreferenceManager prefs = Get.find(tag: (PreferenceManager).toString());
    if (token != null) {
      prefs.setString(PrefsMemory.token, _token!);
    }
    if (account != null) {
      prefs.setString(PrefsMemory.userJson, jsonEncode(_account));
    }
  }

  Future<Account?> isLoginBefore() async {
    PreferenceManager prefs = Get.find(tag: (PreferenceManager).toString());
    String? token = await prefs.getString(PrefsMemory.token);
    if (token.isNotEmpty) {
      _token = token;
      String? userJson = await prefs.getString(PrefsMemory.userJson);
      if (userJson.isNotEmpty) {
        _account.value = Account.fromJson(jsonDecode(userJson));
        loadBalance();
        loadConfigs();
        return _account.value;
      }
    }
    return null;
  }

  Future<void> logout() async {
    Get.context?.loaderOverlay.show(
        widget: const CustomOverlay(
      content: 'Đang đăng xuất',
    ));
    // BackgroundNotificationService.stopService();
    await FirebaseMessagingService.unregisterNotification(_account.value!.id!);
    // BackgroundNotificationService.stopService();
    var future =
        _accountRepo.logout(LogoutModel(accountId: _account.value!.id!));
    await callDataService(future, onError: showError);
    await clearToken();
    Get.context?.loaderOverlay.hide();
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<void> loadBalance() async {
    if (_account.value != null) {
      var future = _accountRepo.getAvailableBalance(_account.value!.id!);
      await callDataService(future,
          onSuccess: (BalanceModel response) {
            _balanceAvailable.value = response;
          },
          onError: showError,
          onStart: () {
            _isLoadingAvailableBalance.value = true;
          },
          onComplete: () {
            _isLoadingAvailableBalance.value = false;
          });
    }
  }

  Future<void> clearToken() async {
    _token = null;
    _account.value = null;
    PreferenceManager prefs = Get.find(tag: (PreferenceManager).toString());
    prefs.remove(PrefsMemory.token);
    prefs.remove(PrefsMemory.userJson);
  }

  // Future<bool> requireCreateRoute() async {
  //   bool? result = false;
  //   if (account?.status == "NO_ROUTE") {
  //     await MaterialDialogService.showConfirmDialog(
  //         msg: 'Bạn có muốn tạo tuyến đường để có thể nhận gói hàng?',
  //         closeOnFinish: false,
  //         onConfirmTap: () async {
  //           result = await Get.toNamed(Routes.SELECT_ROUTE) as bool?;
  //           if (result == true) account?.status = "ACTIVE";
  //           Get.back();
  //           return false;
  //         });
  //   } else {
  //     result = true;
  //   }
  //   return result ?? false;
  // }

  Future<void> loadConfigs() async {
    if (account != null) {
      var future = _accountRepo.getUserConfigs(account!.id!);
      await callDataService(future,
          onSuccess: (List<UserConfig> response) {
            configs.value = [];
            configs.value = response;
          },
          onError: showError,
          onStart: () {
            _isLoadingConfig.value = true;
          },
          onComplete: () {
            _isLoadingConfig.value = false;
          });
    }
  }
}
