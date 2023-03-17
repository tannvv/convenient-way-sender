import 'package:convenient_way_sender/app/core/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:convenient_way_sender/app/core/controllers/auth_controller.dart';
import 'package:convenient_way_sender/app/modules/sender_package/tabs/approved_tab/approved_tab_view.dart';
import 'package:convenient_way_sender/app/modules/sender_package/tabs/deliver_cancel_tab/deliver_cancel_tab_view.dart';
import 'package:convenient_way_sender/app/modules/sender_package/tabs/deliver_pickup_tab/deliver_pickup_tab_view.dart';
import 'package:convenient_way_sender/app/modules/sender_package/tabs/delivered_tab/delivered_tab_view.dart';
import 'package:convenient_way_sender/app/modules/sender_package/tabs/delivery_failed_tab/delivery_failed_tab_view.dart';
import 'package:convenient_way_sender/app/modules/sender_package/tabs/delivery_tab/delivery_tab_view.dart';
import 'package:convenient_way_sender/app/modules/sender_package/tabs/reject_tab/reject_tab_view.dart';
import 'package:convenient_way_sender/app/modules/sender_package/tabs/sender_cancel_tab/sender_cancel_tab_view.dart';
import 'package:convenient_way_sender/app/modules/sender_package/tabs/waiting_tab/waiting_tab_view.dart';

class SenderPackageController extends BaseController
    with GetSingleTickerProviderStateMixin {
  final AuthController authController = Get.find<AuthController>();
  late TabController tabController;
  List<String> tabsTitle = const [
    'Chờ xác nhận',
    'Đã xác nhận',
    'Chờ lấy hàng',
    'Chờ giao hàng',
    'Giao thành công',
    'Giao thất bại',
    'Quản trị viên hủy',
    'Người giao hủy',
    'Đã hủy',
  ];

  final List<Widget> _screens = const [
    WaitingTabView(),
    ApprovedTabView(),
    DeliverPickupTabView(),
    DeliveryTabView(),
    DeliveredTabView(),
    DeliveryFailedTabView(),
    RejectTabView(),
    DeliverCancelTabView(),
    SenderCancelTabView(),
  ];

  List<Widget> get screens => _screens;

  PageStorageBucket bucket = PageStorageBucket();
  final indexScreen = 0.obs;
  Widget get currentScreen => _screens[indexScreen.value];

  void changeTab(int index) {
    indexScreen.value = index;
  }

  @override
  void onInit() {
    tabController = TabController(length: 1, vsync: this);
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
