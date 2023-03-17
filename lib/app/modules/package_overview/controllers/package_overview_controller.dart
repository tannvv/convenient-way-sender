import 'package:convenient_way_sender/app/modules/package_overview/models/header_state.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:get/get.dart';
import 'package:convenient_way_sender/app/core/base/base_paging_controller.dart';
import 'package:convenient_way_sender/app/core/controllers/auth_controller.dart';
import 'package:convenient_way_sender/app/data/models/account_model.dart';
import 'package:convenient_way_sender/app/data/models/suggest_package_model.dart';
import 'package:convenient_way_sender/app/data/repository/package_req.dart';
import 'package:convenient_way_sender/app/data/repository/request_model/suggest_package_request_model.dart';

class PackageOverviewController extends BasePagingController<SuggestPackage> {
  final AuthController _authController = Get.find<AuthController>();
  final HeaderState headerState = HeaderState();

  Account? get account => _authController.account;
  bool get isLoadingBalance => _authController.isLoadingAvailableBalance;
  int get availableBalance => _authController.availableBalance;
  bool get isNewAccount => _authController.isNewAccount;
  String get balanceAccountVND =>
      _authController.account?.balance.toVND() ?? '-';
  String get statusAccount => _authController.account?.status ?? '';

  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());

  void gotoDetail(SuggestPackage suggest) async {}

  void toggleHeader() {
    headerState.toggle();
  }

  @override
  Future<void> fetchDataApi() async {
    String? accountId = _authController.account?.id;
    if (accountId != null) {
      SuggestPackageRequestModel model = SuggestPackageRequestModel(
        deliverId: accountId,
        pageSize: pageSize,
        pageIndex: pageIndex,
      );
      Future<List<SuggestPackage>> future =
          _packageRepo.getSuggestPackage(model);
      await callDataService<List<SuggestPackage>>(future,
          onSuccess: onSuccess, onError: onError);
    }
  }
}
