import 'package:convenient_way_sender/app/data/constants/role_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:convenient_way_sender/app/core/base/base_controller.dart';
import 'package:convenient_way_sender/app/core/controllers/auth_controller.dart';
import 'package:convenient_way_sender/app/core/services/firebase_messaging_service.dart';
import 'package:convenient_way_sender/app/data/repository/request_model/login_model.dart';
import 'package:convenient_way_sender/app/routes/app_pages.dart';

class LoginController extends BaseController {
  final AuthController _authController = Get.find<AuthController>();

  final formKey = GlobalKey<FormState>();
  String userName = '';
  String password = '';
  final RxBool isSignUpMode = false.obs;
  final RxDouble widthForgotPassword = 0.0.obs;
  set isSignUpModeValue(bool value) => isSignUpMode.value = value;

  set setUserName(String value) {
    userName = value;
  }

  set setPassword(String value) {
    password = value;
  }

  void back() {
    Get.back();
  }

  Future<void> gotoSignUp() async {
    await Get.offAndToNamed(Routes.REGISTER);
  }

  Future<void> login() async {
    isLoading = true;
    LoginModel loginModel = LoginModel(
      userName: userName,
      password: password,
      role: RoleName.sender,
      registrationToken: await FirebaseMessagingService.getToken(),
    );
    await _authController.login(loginModel);
    isLoading = false;
  }
}
