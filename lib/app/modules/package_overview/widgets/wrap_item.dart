import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:convenient_way_sender/app/core/values/app_colors.dart';
import 'package:convenient_way_sender/app/core/values/shadow_styles.dart';
import 'package:convenient_way_sender/app/core/widgets/button_color.dart';

class WrapItem extends StatelessWidget {
  const WrapItem({super.key, required this.child, this.onPressedDetail});
  final Widget child;
  final Function()? onPressedDetail;
  @override
  Widget build(BuildContext context) {
    double borderRadius = 12.w;
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow: ShadowStyles.primary),
          child: child,
        ),
        onPressedDetail != null
            ? Positioned(
                top: -5.2.h,
                right: 0.w,
                child: ColorButton(
                  'Xem chi tiết',
                  icon: Icons.exit_to_app_outlined,
                  onPressed: onPressedDetail,
                  backgroundColor: AppColors.blue,
                  textColor: AppColors.blue,
                  radius: 0,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(borderRadius),
                      bottomLeft: Radius.circular(borderRadius)),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
                ),
              )
            : Container(),
      ],
    );
  }
}
