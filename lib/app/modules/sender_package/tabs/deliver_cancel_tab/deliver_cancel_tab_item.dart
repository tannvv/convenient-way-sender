import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:convenient_way_sender/app/data/models/package_cancel_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:convenient_way_sender/app/modules/sender_package/widgets/user_info.dart';
import 'package:convenient_way_sender/app/modules/sender_package/widgets/wrap_item.dart';

import '../../widgets/location_start_end.dart';
import '../../widgets/package_cancel_info.dart';

class DeliverCancelTabItem extends StatelessWidget {
  const DeliverCancelTabItem(
      {Key? key, required this.package, required this.onShowDeliverInfo})
      : super(key: key);
  final PackageCancel package;
  final Function() onShowDeliverInfo;
  @override
  Widget build(BuildContext context) {
    return WrapItem(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        UserInfo(info: package.deliver!.infoUser!),
        LocationStartEnd(
            locationStart: package.startAddress!,
            locationEnd: package.destinationAddress!),
        Gap(12.h),
        PackageCancelInfo(
          package: package,
        ),
        Gap(12.h),
      ]),
    );
  }
}
