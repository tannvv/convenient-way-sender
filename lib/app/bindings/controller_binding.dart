import 'package:get/get.dart';
import 'package:convenient_way_sender/app/core/controllers/auth_controller.dart';
import 'package:convenient_way_sender/app/core/controllers/pickup_file_controller.dart';

class ControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.lazyPut<PickUpFileController>(() => PickUpFileController(),
        fenix: true);
  }
}
