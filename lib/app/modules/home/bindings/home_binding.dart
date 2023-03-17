import 'package:get/get.dart';
import 'package:convenient_way_sender/app/modules/sender_package/tabs/approved_tab/approved_tab_controller.dart';
import 'package:convenient_way_sender/app/modules/sender_package/tabs/deliver_cancel_tab/deliver_cancel_tab_controller.dart';
import 'package:convenient_way_sender/app/modules/sender_package/tabs/deliver_pickup_tab/deliver_pickup_tab_controller.dart';
import 'package:convenient_way_sender/app/modules/sender_package/tabs/delivered_tab/delivered_tab_controller.dart';
import 'package:convenient_way_sender/app/modules/sender_package/tabs/delivery_failed_tab/delivery_failed_tab_controller.dart';
import 'package:convenient_way_sender/app/modules/sender_package/tabs/delivery_tab/delivery_tab_controller.dart';
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
    Get.lazyPut<DeliverPickupTabController>(() => DeliverPickupTabController());
    Get.lazyPut<DeliveredTabController>(() => DeliveredTabController());
    Get.lazyPut<DeliveryFailedTabController>(
        () => DeliveryFailedTabController());
    Get.lazyPut<DeliveryTabController>(() => DeliveryTabController());
    Get.lazyPut<RejectTabController>(() => RejectTabController());
    Get.lazyPut<SenderCancelTabController>(() => SenderCancelTabController());
    Get.lazyPut<SuccessTabController>(() => SuccessTabController());
    Get.lazyPut<WaitingTabController>(() => WaitingTabController());
  }
}
