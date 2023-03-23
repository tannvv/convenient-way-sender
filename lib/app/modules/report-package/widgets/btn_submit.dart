import 'package:convenient_way_sender/app/modules/report-package/controllers/report_package_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../core/values/app_colors.dart';

class BtnSubmitReportPackage extends GetWidget<ReportPackageController> {
  const BtnSubmitReportPackage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.w, vertical: 12.h),
                  backgroundColor: AppColors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                onPressed: () {
                  // controller.onPickupFailed();
                },
                child: const Text('Gửi thông tin'))
          ],
        )
      ],
    );
  }
}
