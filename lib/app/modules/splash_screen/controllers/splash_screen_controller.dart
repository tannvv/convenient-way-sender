import 'package:get/get.dart';
import 'package:convenient_way_sender/app/core/controllers/auth_controller.dart';
import 'package:convenient_way_sender/app/data/models/account_model.dart';
import 'package:convenient_way_sender/app/routes/app_pages.dart';

class SplashScreenController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();
  Future<String> screenRouteFunction() async {
    Account? account = await _authController.isLoginBefore();
    if (account != null) {
      // return account.status == AccountStatus.noRoute
      //     ? Routes.CREATE_ROUTE
      //     : Routes.HOME;
      return Routes.HOME;
    }
    return Routes.LOGIN;
  }
}
