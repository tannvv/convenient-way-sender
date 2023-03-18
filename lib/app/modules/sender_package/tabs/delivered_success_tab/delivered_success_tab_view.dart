import 'package:convenient_way_sender/app/modules/sender_package/tabs/delivered_success_tab/delivered_success_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:convenient_way_sender/app/core/widgets/custom_footer_smart_refresh.dart';

import 'delivered_success_tab_item.dart';

class DeliveredSuccessTabView extends GetView<DeliveredSuccessTabController> {
  const DeliveredSuccessTabView({Key? key}) : super(key: key);
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
                        DeliveredSuccessTabItem(
                          package: controller.dataApis[index],
                          showInfoDeliver: () => controller.showInfoDeliver(
                              controller.dataApis[index].deliver!),
                          onConfirmFailed: () => controller
                              .confirmFailed(controller.dataApis[index].id!),
                          onConfirmSuccess: () => controller
                              .confirmSuccess(controller.dataApis[index].id!),
                          onSendFeedbackDriver: () => {
                            controller.sendFeedback(controller.dataApis[index])
                          },
                          onPressedDetail: () =>
                              controller.gotoDetail(controller.dataApis[index]),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (_, index) => Gap(12.h),
                  itemCount: controller.dataApis.length),
            )));
  }
}
