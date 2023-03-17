import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:convenient_way_sender/app/core/widgets/custom_footer_smart_refresh.dart';
import 'package:convenient_way_sender/app/modules/sender_package/tabs/deliver_pickup_tab/deliver_pickup_tab_controller.dart';
import 'package:convenient_way_sender/app/modules/sender_package/tabs/deliver_pickup_tab/deliver_pickup_tab_item.dart';

class DeliverPickupTabView extends GetView<DeliverPickupTabController> {
  const DeliverPickupTabView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        child: Obx(() => SmartRefresher(
              controller: controller.refreshController,
              onRefresh: () => controller.onRefresh(),
              onLoading: () => controller.onLoading(),
              footer: CustomFooterSmartRefresh.defaultCustom(),
              child: ListView.separated(
                  itemBuilder: (_, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DeliverPickupTabItem(
                            package: controller.dataApis[index],
                            onConfirmPackage: () =>
                                controller.accountConfirmPackage(
                                    controller.dataApis[index].id!),
                            onCodeConfirm: () => controller.senderConfirmCode(
                                controller.dataApis[index].id!),
                            showMapTracking: () => controller
                                .showMapTracking(controller.dataApis[index]),
                            onShowQR: () => controller
                                .showQRCode(controller.dataApis[index].id!),
                            onShowDeliverInfo: () => controller.showInfoDeliver(
                                controller.dataApis[index].deliver!))
                      ],
                    );
                  },
                  separatorBuilder: (_, index) => Gap(16.h),
                  itemCount: controller.dataApis.length),
            )));
  }
}
