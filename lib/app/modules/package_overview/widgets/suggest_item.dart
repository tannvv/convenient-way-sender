import 'package:convenient_way_sender/app/core/values/app_colors.dart';
import 'package:convenient_way_sender/app/core/values/shadow_styles.dart';
import 'package:convenient_way_sender/app/data/models/package_model.dart';
import 'package:convenient_way_sender/app/modules/package_overview/widgets/location_start_end.dart';
import 'package:convenient_way_sender/app/modules/package_overview/widgets/package_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ListPackageItem extends StatelessWidget {
  const ListPackageItem({Key? key, required this.listPackage})
      : super(key: key);
  final Package listPackage;
  @override
  Widget build(BuildContext context) {
    // num countPackage = listPackage.length ?? 0;
    // List<Product>? products = listPackage.products;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(6.w),
          boxShadow: ShadowStyles.primary),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Row(
      //           children: [
      //             const Text(
      //               'Số gói hàng: ',
      //             ),
      //             Text(
      //               '$countPackage',
      //               style: subtitle2,
      //             ),
      //           ],
      //         ),
      //         Text(
      //           '${listPackage.getTotalPrice().toVND()}',
      //           style: subtitle2.copyWith(
      //             color: AppColors.primary800,
      //             fontWeight: FontWeights.medium,
      //           ),
      //         )
      //       ],
      //     ),
      //     Row(
      //       children: [
      //         const Text('Sản phẩm: '),
      //         Expanded(
      //           child: Text(
      //             "San pham",
      //             style: subtitle2,
      //             overflow: TextOverflow.ellipsis,
      //           ),
      //         ),
      //       ],
      //     ),
      //     Row(
      //       children: [
      //         const Text('Điểm gửi hàng: '),
      //         Expanded(
      //           child: Text(
      //             '${listPackage.startAddress}',
      //             style: subtitle2,
      //             overflow: TextOverflow.ellipsis,
      //           ),
      //         ),
      //       ],
      //     ),
      //     Row(
      //       children: [
      //         const Text('Tổng phí vận chuyển: '),
      //         Text(
      //           listPackage.priceShip.toVND(),
      //           style: subtitle2,
      //         ),
      //       ],
      //     )
      //   ],
      // ),
      // child: WrapItem(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mã đơn hàng:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            Text(
              '${listPackage.id}',
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,),
            LocationStartEnd(
                locationStart: listPackage.startAddress!,
                locationEnd: listPackage.destinationAddress!),
            Gap(8.h),
            PackageInfo(
              package: listPackage,
            ),
            Gap(8.h),
            Text(
              'Trạng thái đơn hàng: ${listPackage.status}',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            // Text('${listPackage.status}'),
          ],
        ),
      // ),
    );
  }
}
