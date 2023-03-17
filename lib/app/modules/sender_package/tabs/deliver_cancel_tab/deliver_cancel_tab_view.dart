import 'package:convenient_way_sender/app/core/widgets/custom_footer_smart_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:convenient_way_sender/app/modules/sender_package/tabs/deliver_cancel_tab/deliver_cancel_tab_controller.dart';

import 'deliver_cancel_tab_item.dart';

class DeliverCancelTabView extends GetView<DeliverCancelTabController> {
  const DeliverCancelTabView({Key? key}) : super(key: key);

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
                        DeliverCancelTabItem(
                          package: controller.dataApis[index],
                          onShowDeliverInfo: () => controller.showInfoDeliver(
                              controller.dataApis[index].deliver!),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (_, index) => Gap(16.h),
                  itemCount: controller.dataApis.length),
            )));
  }
}
