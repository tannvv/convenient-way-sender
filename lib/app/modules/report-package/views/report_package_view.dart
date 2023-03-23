import 'package:convenient_way_sender/app/modules/report-package/controllers/report_package_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/widgets/header_scaffold.dart';
import '../widgets/btn_submit.dart';
import '../widgets/image_select.dart';
import '../widgets/wrap_reasons.dart';

class ReportPackageView extends GetView<ReportPackageController> {
  const ReportPackageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              HeaderScaffold(
                title: '',
                isBack: true,
              ),
              WrapReason(),
              ImageSelectReportPackage(),
              BtnSubmitReportPackage(),
            ],
          ),
        ),
      ),
    );
  }
}
