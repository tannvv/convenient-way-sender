import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:convenient_way_sender/app/core/values/app_colors.dart';
import 'package:convenient_way_sender/app/core/values/shadow_styles.dart';
import 'package:convenient_way_sender/app/core/widgets/button_color.dart';
import 'package:convenient_way_sender/app/data/models/package_model.dart';
import 'package:convenient_way_sender/app/modules/sender_package/widgets/location_start_end.dart';
import 'package:convenient_way_sender/app/modules/sender_package/widgets/package_info.dart';
import 'package:convenient_way_sender/app/modules/sender_package/widgets/wrap_item.dart';

class ApprovedTabItem extends StatelessWidget {
  const ApprovedTabItem(
      {Key? key, required this.package, required this.onCancelPackage})
      : super(key: key);
  final Package package;
  final Function() onCancelPackage;

  @override
  Widget build(BuildContext context) {
    return WrapItem(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LocationStartEnd(
              locationStart: package.startAddress!,
              locationEnd: package.destinationAddress!),
          Gap(12.h),
          PackageInfo(
            package: package,
          ),
          Gap(12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ColorButton(
                'Hủy',
                icon: Icons.delete,
                onPressed: onCancelPackage,
                backgroundColor: Colors.red,
                textColor: Colors.red,
                radius: 8.sp,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
              )
            ],
          )
        ],
      ),
    );
  }
}
