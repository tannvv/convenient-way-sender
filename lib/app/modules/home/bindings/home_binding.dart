import 'package:convenient_way_sender/app/modules/sender_package/tabs/delivered_failed_tab/delivered_failed_tab_controller.dart';
import 'package:convenient_way_sender/app/modules/sender_package/tabs/delivered_success_tab/delivered_success_tab_controller.dart';
import 'package:convenient_way_sender/app/modules/sender_package/tabs/pickup_success_tab/pickup_success_tab_controller.dart';
import 'package:convenient_way_sender/app/modules/sender_package/tabs/selected_tab/selected_tab_controller.dart';
import 'package:get/get.dart';
import 'package:convenient_way_sender/app/modules/sender_package/tabs/approved_tab/approved_tab_controller.dart';
import 'package:convenient_way_sender/app/modules/sender_package/tabs/deliver_cancel_tab/deliver_cancel_tab_controller.dart';
import 'package:convenient_way_sender/app/modules/sender_package/tabs/reject_tab/reject_tab_controller.dart';
import 'package:convenient_way_sender/app/modules/sender_package/tabs/sender_cancel_tab/sender_cancel_tab_controller.dart';
import 'package:convenient_way_sender/app/modules/sender_package/tabs/success_tab/success_tab_controller.dart';
import 'package:convenient_way_sender/app/modules/sender_package/tabs/waiting_tab/waiting_tab_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    senderTabController();
  }

  void senderTabController() {
    Get.lazyPut<ApprovedTabController>(() => ApprovedTabController());
    Get.lazyPut<DeliverCancelTabController>(() => DeliverCancelTabController());
    Get.lazyPut<RejectTabController>(() => RejectTabController());
    Get.lazyPut<SenderCancelTabController>(() => SenderCancelTabController());
    Get.lazyPut<SuccessTabController>(() => SuccessTabController());
    Get.lazyPut<WaitingTabController>(() => WaitingTabController());

    Get.lazyPut<SelectedTabController>(() => SelectedTabController());
    Get.lazyPut<PickupSuccessTabController>(() => PickupSuccessTabController());
    Get.lazyPut<DeliveredFailedTabController>(
        () => DeliveredFailedTabController());
    Get.lazyPut<DeliveredSuccessTabController>(
        () => DeliveredSuccessTabController());
  }
}
