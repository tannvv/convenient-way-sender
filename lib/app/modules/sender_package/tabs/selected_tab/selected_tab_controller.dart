import 'dart:async';
import 'package:barcode/barcode.dart';
<<<<<<< HEAD
import 'package:convenient_way_sender/app/core/services/firebase_messaging_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
=======
import 'package:convenient_way_sender/app/data/repository/request_model/cancel_package_model.dart';
>>>>>>> 9a49ab58b69af07092a51f822df50f8107dd17e3
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:convenient_way_sender/app/core/base/sender_tab_base_controller.dart';
import 'package:convenient_way_sender/app/core/controllers/auth_controller.dart';
import 'package:convenient_way_sender/app/core/controllers/pickup_file_controller.dart';
import 'package:convenient_way_sender/app/core/utils/material_dialog_service.dart';
import 'package:convenient_way_sender/app/core/utils/toast_service.dart';
import 'package:convenient_way_sender/app/core/values/app_colors.dart';
import 'package:convenient_way_sender/app/core/values/font_weight.dart';
import 'package:convenient_way_sender/app/core/values/input_styles.dart';
import 'package:convenient_way_sender/app/core/values/text_styles.dart';
import 'package:convenient_way_sender/app/core/widgets/button_color.dart';
import 'package:convenient_way_sender/app/data/constants/package_status.dart';
import 'package:convenient_way_sender/app/data/models/package_model.dart';
import 'package:convenient_way_sender/app/data/repository/package_req.dart';
import 'package:convenient_way_sender/app/data/repository/request_model/package_list_model.dart';

class SelectedTabController extends SenderTabBaseController<Package>
    with GetSingleTickerProviderStateMixin {
  final AuthController _authController = Get.find<AuthController>();
  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());

  @override
  void onInit() {
    super.onInit();
    onListeningChange();
  }

  @override
  Future<void> fetchDataApi() async {
    PackageListModel requestModel = PackageListModel(
        senderId: _authController.account!.id,
        status: PackageStatus.SELECTED,
        pageIndex: pageIndex,
        pageSize: pageSize);
    Future<List<Package>> future = _packageRepo.getList(requestModel);
    await callDataService<List<Package>>(future,
        onSuccess: onSuccess, onError: onError);
  }

  Future<void> accountConfirmPackage(String packageId) async {
    if (await PickUpFileController().scanQR() == packageId.split('-')[0]) {
      MaterialDialogService.showConfirmDialog(
        msg: 'Xác nhân đã đưa hàng cho đúng người lấy hàng giùm?',
        closeOnFinish: false,
        onConfirmTap: () async {
          var future = _packageRepo.pickupSuccess(packageId);
          callDataService(future, onStart: showOverlay, onComplete: hideOverlay,
              onSuccess: (response) {
            Get.back();
            onRefresh();
            _authController.reloadAccount();
            ToastService.showSuccess(
                'Xác nhận đã đưa gói hàng cho người lấy hàng giùm!');
          }, onError: (exception) {
            Get.back();
            showError(exception);
          });
        },
      );
    }
  }

  Future<void> senderConfirmCode(String packageId) async {
    confirmCode(() => {confirmCodeFromQR(packageId)});
  }

  Future<void> confirmCodeFromQR(String packageId) async {
    if (code == null || code != (packageId.split('-')[0])) {
      ToastService.showError('Mã số sai, vui lòng quét mã QR và kiểm tra lại!',
          seconds: 5);
      return;
    }
    if (code == packageId.split('-')[0]) {
      var future = _packageRepo.pickupSuccess(packageId);
      callDataService(future, onStart: showOverlay, onComplete: hideOverlay,
          onSuccess: (response) {
        Get.back();
        onRefresh();
        _authController.reloadAccount();
        ToastService.showSuccess(
            'Xác nhận đã đưa gói hàng cho người lấy hàng giùm!');
      }, onError: (exception) {
        Get.back();
        showError(exception);
      });
    }
  }

  Widget _confirmCodeWidget() {
    return Container(
      padding: EdgeInsets.only(top: 40.h),
      height: 100.h,
      width: 220.w,
      child: TextField(
        onChanged: (value) {
          code = value;
        },
        autofocus: true,
        decoration: InputStyles.reasonCancel(labelText: 'Nhập mã xác nhận'),
      ),
    );
  }

  Future<void> confirmCode(Function() callback) async {
    await Dialogs.materialDialog(
        context: Get.context!,
        customView: _confirmCodeWidget(),
        actions: [
          IconsButton(
            onPressed: () {
              Get.back();
            },
            text: 'Thoát',
            iconData: Icons.arrow_back_ios_new,
            color: const Color.fromARGB(255, 204, 203, 203),
            textStyle: const TextStyle(color: Colors.black38),
            iconColor: Colors.black38,
          ),
          IconsButton(
            onPressed: () {
              callback();
              Get.back();
            },
            text: 'Xác nhận',
            iconData: Icons.check,
            color: Colors.blue,
            textStyle: const TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }

  Future<void> showQRCode(String packageId) async {
    final svg = Barcode.qrCode()
        .toSvg(packageId.split('-')[1] + packageId.split('-')[2]);
    await Dialogs.materialDialog(
        dialogWidth: 400.w,
        context: Get.context!,
        customView: _qrCodeWidget(
            svg, packageId.split('-')[1] + packageId.split('-')[2]));
  }

  Widget _qrCodeWidget(String svg, String packageId) {
    return Container(
      padding: EdgeInsets.only(top: 40.h, right: 40.w, left: 40.w),
      child: Column(
        children: [
          Text(
            'Dùng mã này để xác nhận người lấy hàng giùm.',
            style: subtitle2,
          ),
          Gap(4.h),
          RichText(
              text: TextSpan(
                  text: 'Chú ý:',
                  style: caption.copyWith(
                      color: Colors.red[600],
                      fontWeight: FontWeights.medium,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline),
                  children: [
                TextSpan(
                    text:
                        ' Tuyệt đối không chia sẽ mã này với người không liên quan.',
                    style: caption.copyWith(decoration: TextDecoration.none))
              ])),
          Gap(20.h),
          SizedBox(
            height: 200.h,
            width: 200.w,
            child: SvgPicture.string(
              svg,
              fit: BoxFit.cover,
            ),
          ),
          Gap(20.h),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ColorButton(
              'Mã xác nhận: $packageId',
              icon: Icons.verified,
              onPressed: () {},
              backgroundColor: AppColors.green,
              textColor: AppColors.green,
              radius: 8.sp,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
            ),
            RichText(
                text: TextSpan(
                    text: 'Chú ý:',
                    style: caption.copyWith(
                        color: Colors.red[600],
                        fontWeight: FontWeights.medium,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline),
                    children: [
                  TextSpan(
                      text:
                          ' Dùng mã này để xác nhận với người nhận lấy hàng giùm.',
                      style: caption.copyWith(decoration: TextDecoration.none))
                ])),
          ]),
        ],
      ),
    );
  }

<<<<<<< HEAD
  void onListeningChange() {
    FirebaseMessaging.onMessage.listen((event) {
      if(event.notification?.title == "Lấy hàng thành công" ||
      event.notification?.title == "Lấy hàng thất bại"){
        onRefresh();
      }
    });
  }

=======
  Future<void> senderCancelPackage(Package package) async {
    MaterialDialogService.showDeleteDialog(
        onConfirmTap: () {
          CancelPackageModel model = CancelPackageModel(
            packageId: package.id!,
            reason: '',
          );
          var future = _packageRepo.senderCancel(model);
          callDataService(future, onStart: showOverlay, onComplete: hideOverlay,
              onSuccess: (response) {
            ToastService.showSuccess('Hủy gói hàng thành công');
            onRefresh();
          }, onError: showError);
        },
        title: 'Xác nhận',
        msg:
            'Bạn chắc chắn muốn hủy kiện hàng này, bạn sẽ bị trừ (${package.priceShip.toVND()}) ?');
  }
>>>>>>> 9a49ab58b69af07092a51f822df50f8107dd17e3
}
