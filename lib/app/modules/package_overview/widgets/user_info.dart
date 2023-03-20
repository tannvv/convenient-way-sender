import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:convenient_way_sender/app/core/values/app_assets.dart';
import 'package:convenient_way_sender/app/core/values/font_weight.dart';
import 'package:convenient_way_sender/app/core/values/text_styles.dart';
import 'package:convenient_way_sender/app/data/models/info_user_model.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key, required this.info, this.onTap}) : super(key: key);
  final InfoUser info;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    String? fname = info.firstName;
    String? lname = info.lastName;
    return InkWell(
      onTap: onTap,
      highlightColor: Colors.black.withOpacity(0.08),
      child: Ink(
        child: Row(
          children: [
            ClipOval(
              child: SizedBox.fromSize(
                size: Size.fromRadius(18.r), // Image radius
                child: CachedNetworkImage(
                  fadeInDuration: const Duration(),
                  fadeOutDuration: const Duration(),
                  placeholder: (context, url) {
                    return info.gender == 'FEMALE'
                        ? SvgPicture.asset(AppAssets.female)
                        : SvgPicture.asset(AppAssets.male);
                  },
                  imageUrl: info.photoUrl ?? '-',
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) {
                    return info.gender == 'FEMALE'
                        ? SvgPicture.asset(AppAssets.female)
                        : SvgPicture.asset(AppAssets.male);
                  },
                ),
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Text(
              '$fname $lname',
              style: subtitle1.copyWith(
                fontWeight: FontWeights.medium,
                color: Colors.black54,
              ),
            )
          ],
        ),
      ),
    );
  }
}
