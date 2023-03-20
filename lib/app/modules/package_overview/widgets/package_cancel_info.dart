import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:convenient_way_sender/app/core/values/text_styles.dart';
import 'package:convenient_way_sender/app/data/models/package_cancel_model.dart';

class PackageCancelInfo extends StatelessWidget {
  const PackageCancelInfo({super.key, required this.package});
  final PackageCancel package;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text('Tên người nhận: '),
            Text(
              '${package.receiverName}',
              style: subtitle2,
            ),
          ],
        ),
        Gap(4.h),
        Row(
          children: [
            const Text('Sản phẩm: '),
            Expanded(
              child: Text(
                package.getProductNames(),
                style: subtitle2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Gap(4.h),
        Row(
          children: [
            const Text('Phí vận chuyển: '),
            Text(
              package.priceShip?.toVND() ?? '',
              style: subtitle2,
            ),
          ],
        ),
      ],
    );
  }
}
