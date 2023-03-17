import 'package:get/get.dart';
import 'package:convenient_way_sender/app/core/controllers/auth_controller.dart';
import 'package:convenient_way_sender/app/core/model/payment_result.dart';
import 'package:convenient_way_sender/app/modules/profile_page/controllers/profile_page_controller.dart';
import 'package:convenient_way_sender/app/routes/app_pages.dart';

class PaymentStatusController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();

  PaymentResult paymentResult = PaymentResult();

  @override
  void onInit() {
    if (Get.arguments != null) {
      paymentResult = Get.arguments['paymentResult'] as PaymentResult;
      if (paymentResult.status) {
        _authController.reloadAccount();
      }
    }
    super.onInit();
  }

  void returnProfilePage() {
    ProfilePageController profileController = Get.find<ProfilePageController>();
    profileController.account?.balance = _authController.account?.balance;
    Get.offAllNamed(Routes.HOME, arguments: {'initialPageIndex': '0'});
    Get.back();
  }
}
