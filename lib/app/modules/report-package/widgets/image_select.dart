import 'package:convenient_way_sender/app/core/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../controllers/report_package_controller.dart';
import 'images_view.dart';

class ImageSelectReportPackage extends GetWidget<ReportPackageController> {
  const ImageSelectReportPackage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(32.h),
        Text(
          'Vui lòng chụp ảnh để chứng minh?',
          style: subtitle1.copyWith(
              fontWeight: FontWeight.bold, color: Colors.grey[500]),
        ),
        Gap(16.h),
        const ImagesViewReportPackage(),
        Gap(16.h),
      ],
    );
  }
}
