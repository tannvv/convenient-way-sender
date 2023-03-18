import 'package:convenient_way_sender/app/core/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:convenient_way_sender/app/core/controllers/auth_controller.dart';
import 'package:convenient_way_sender/app/modules/sender_package/tabs/approved_tab/approved_tab_view.dart';
import 'package:convenient_way_sender/app/modules/sender_package/tabs/waiting_tab/waiting_tab_view.dart';

import '../tabs/delivered_failed_tab/delivered_failed_tab_view.dart';
import '../tabs/delivered_success_tab/delivered_success_tab_view.dart';
import '../tabs/pickup_success_tab/pickup_success_tab_view.dart';
import '../tabs/selected_tab/selected_tab_view.dart';

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
  ];

  final List<Widget> _screens = const [
    WaitingTabView(),
    ApprovedTabView(),
    SelectedTabView(),
    PickupSuccessTabView(),
    DeliveredSuccessTabView(),
    DeliveryFailedTabView(),
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
