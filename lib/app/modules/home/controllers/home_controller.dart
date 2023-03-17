// ignore_for_file: unused_field

import 'package:convenient_way_sender/app/modules/notification_page/controllers/notification_page_controller.dart';
import 'package:convenient_way_sender/app/modules/notification_page/views/notification_page_view.dart';
import 'package:convenient_way_sender/app/modules/package_overview/controllers/package_overview_controller.dart';
import 'package:convenient_way_sender/app/modules/package_overview/views/package_overview_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:convenient_way_sender/app/modules/profile_page/controllers/profile_page_controller.dart';
import 'package:convenient_way_sender/app/modules/profile_page/views/profile_page_view.dart';
import 'package:convenient_way_sender/app/modules/sender_package/controllers/sender_package_controller.dart';
import 'package:convenient_way_sender/app/modules/sender_package/views/sender_package_view.dart';

class HomeController extends GetxController {
  late SenderPackageController _senderPackageController;
  late NotificationPageController _notifyController;
  late ProfilePageController _profileController;
  late PackageOverviewController _packageOverviewController;

  final _selectedIndex = Get.arguments != null
      ? int.parse(Get.arguments['initialPageIndex']).obs
      : 0.obs;

  int get selectedIndex => _selectedIndex.value;
  set selectedIndex(int value) {
    _selectedIndex.value = value;
  }

  final count = 0.obs;

  final List<Widget> _widgetOptions = [
    PackageOverviewView(),
    SenderPackageView(),
    const NotificationPageView(),
    ProfilePageView(),
  ];

  PageStorageBucket bucket = PageStorageBucket();
  Widget get currentScreen => _widgetOptions[_selectedIndex.value];

  void changeTab(int index) {
    _selectedIndex.value = index;
  }

  @override
  void onInit() {
    initController();
    super.onInit();
  }

  Future<void> initController() async {
    Get.put(SenderPackageController(), permanent: true);
    _senderPackageController = Get.find<SenderPackageController>();
    Get.put(ProfilePageController(), permanent: true);
    _profileController = Get.find<ProfilePageController>();
    Get.put(NotificationPageController(), permanent: true);
    _notifyController = Get.find<NotificationPageController>();
    Get.put(PackageOverviewController(), permanent: true);
    _packageOverviewController = Get.find<PackageOverviewController>();
  }
}
