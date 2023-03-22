import 'package:get/get.dart';

import '../controllers/report_package_controller.dart';

class ReportPackageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportPackageController>(
      () => ReportPackageController(),
    );
  }
}
