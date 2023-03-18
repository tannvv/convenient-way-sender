import 'package:convenient_way_sender/app/core/utils/material_dialog_service.dart';
import 'package:convenient_way_sender/app/core/values/app_colors.dart';
import 'package:convenient_way_sender/app/core/values/text_styles.dart';
import 'package:convenient_way_sender/app/modules/create_package_page/controllers/create_package_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:time_range_picker/time_range_picker.dart';

class SelectTime extends GetWidget<CreatePackagePageController> {
  const SelectTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _selectTime(context),
          Gap(12.h),
          _pickupTime(),
          Gap(20.h),
          _selectTimeDelivery(
            context,
          ),
          Gap(12.h),
          _deliveryTime(),
          Gap(20.h),
          _selectTimeExpiredBtn(context),
          Gap(12.h),
          _displayExpiredTime()
        ],
      ),
    );
  }

  ElevatedButton _selectTime(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () async {
          TimeRange? timeRange = await showTimeRangePickupDialog(context);
          controller.selectedTimePickup(timeRange);
        },
        icon: const Icon(Icons.timelapse_outlined),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.blue),
            padding: MaterialStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.sp)))),
        label: const Text('Chọn thời gian lấy hàng'));
  }

  Widget _pickupTime() {
    return Obx(() {
      if (controller.pickupTimeStart.value == null ||
          controller.pickupTimeEnd.value == null) return Container();
      return Text(
        '${controller.pickupTimeStart.value?.hour}:${controller.pickupTimeStart.value?.minute} - ${controller.pickupTimeEnd.value?.hour}:${controller.pickupTimeEnd.value?.minute}',
        style: subtitle1.copyWith(
          color: AppColors.lightBlack,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.italic,
        ),
      );
    });
  }

  Future<TimeRange?> showTimeRangePickupDialog(
    BuildContext context,
  ) async {
    return await await showTimeRangePicker(
        context: context,
        minDuration: const Duration(hours: 2),
        hideTimes: false,
        disabledColor: Colors.red.withOpacity(0.5),
        strokeWidth: 4,
        ticks: 24,
        ticksColor: Colors.grey,
        labels: [
          "12 am",
          "3 am",
          "6 am",
          "9 am",
          "12 pm",
          "3 pm",
          "6 pm",
          "9 pm"
        ].asMap().entries.map((e) {
          return ClockLabel.fromIndex(idx: e.key, length: 8, text: e.value);
        }).toList(),
        labelOffset: 35,
        rotateLabels: false,
        padding: 60,
        disabledTime: TimeRange(
            startTime: const TimeOfDay(hour: 0, minute: 0),
            endTime: const TimeOfDay(hour: 5, minute: 0)),
        fromText: 'Từ',
        start: const TimeOfDay(hour: 6, minute: 0),
        end: const TimeOfDay(hour: 10, minute: 0),
        toText: 'Đến');
  }

  ElevatedButton _selectTimeDelivery(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () async {
          TimeRange? timeRange = await showTimeRangePicker(
              context: context,
              minDuration: const Duration(hours: 2),
              hideTimes: false,
              disabledColor: Colors.red.withOpacity(0.5),
              strokeWidth: 4,
              ticks: 24,
              ticksColor: Colors.grey,
              labels: [
                "12 am",
                "3 am",
                "6 am",
                "9 am",
                "12 pm",
                "3 pm",
                "6 pm",
                "9 pm"
              ].asMap().entries.map((e) {
                return ClockLabel.fromIndex(
                    idx: e.key, length: 8, text: e.value);
              }).toList(),
              labelOffset: 35,
              rotateLabels: false,
              padding: 60,
              disabledTime: TimeRange(
                  startTime: const TimeOfDay(hour: 0, minute: 0),
                  endTime: const TimeOfDay(hour: 5, minute: 0)),
              fromText: 'Từ',
              start: const TimeOfDay(hour: 15, minute: 0),
              end: const TimeOfDay(hour: 19, minute: 0),
              toText: 'Đến');
          controller.selectedTimeDelivery(timeRange);
        },
        icon: const Icon(Icons.timelapse_outlined),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.blue),
            padding: MaterialStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.sp)))),
        label: const Text('Chọn thời gian giao hàng'));
  }

  Widget _deliveryTime() {
    return Obx(() {
      if (controller.deliveryTimeStart.value == null ||
          controller.deliveryTimeEnd.value == null) return Container();
      return Text(
        '${controller.deliveryTimeStart.value?.hour}:${controller.deliveryTimeStart.value?.minute} - ${controller.deliveryTimeEnd.value?.hour}:${controller.deliveryTimeEnd.value?.minute}',
        style: subtitle1.copyWith(
          color: AppColors.lightBlack,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.italic,
        ),
      );
    });
  }

  ElevatedButton _selectTimeExpiredBtn(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () async {
          MaterialDialogService.showEmptyDialog(
              child: Column(
            children: [
              _selectTimeExpired(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text('Đồng ý'))
                ],
              )
            ],
          ));
        },
        icon: const Icon(Icons.timelapse_outlined),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.blue),
            padding: MaterialStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.sp)))),
        label: const Text('Thời gian hết hạn bài đăng'));
  }

  Widget _selectTimeExpired(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: SfDateRangePicker(
        onSelectionChanged: controller.selectedExpiredTime,
        selectionMode: DateRangePickerSelectionMode.single,
        initialSelectedDate: DateTime.now().add(const Duration(days: 2)),
        enablePastDates: false,
        maxDate: DateTime.now().add(const Duration(days: 7)),
      ),
    );
  }

  Widget _displayExpiredTime() {
    return Obx(() => controller.expiredDate.value == null
        ? Container()
        : Text(
            'Bài đăng của bạn sẽ hết hạn sau: \n${controller.getExpiredTime}',
            style: subtitle1.copyWith(
              color: AppColors.lightBlack,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
            ),
          ));
  }
}
