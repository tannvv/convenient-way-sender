import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:convenient_way_sender/app/core/widgets/custom_footer_smart_refresh.dart';
import 'package:convenient_way_sender/app/modules/sender_package/tabs/success_tab/success_tab_controller.dart';

import 'success_tab_item.dart';

class SuccessTabView extends GetView<SuccessTabController> {
  const SuccessTabView({Key? key}) : super(key: key);
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
                        SuccessTabItem(
                            package: controller.dataApis[index],
                            onPressedDetail: () => controller
                                .gotoDetail(controller.dataApis[index]),
                            onSendFeedbackDriver: () => {
                                  controller
                                      .sendFeedback(controller.dataApis[index])
                                },
                            showInfoDeliver: () => controller.showInfoDeliver(
                                controller.dataApis[index].deliver!)),
                      ],
                    );
                  },
                  separatorBuilder: (_, index) => Gap(12.h),
                  itemCount: controller.dataApis.length),
            )));
  }
}
