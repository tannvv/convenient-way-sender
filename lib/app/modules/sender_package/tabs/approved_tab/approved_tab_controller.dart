import 'package:convenient_way_sender/app/core/utils/material_dialog_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:convenient_way_sender/app/core/base/base_paging_controller.dart';
import 'package:convenient_way_sender/app/core/controllers/auth_controller.dart';
import 'package:convenient_way_sender/app/core/utils/toast_service.dart';
import 'package:convenient_way_sender/app/core/values/text_styles.dart';
import 'package:convenient_way_sender/app/data/constants/package_status.dart';
import 'package:convenient_way_sender/app/data/models/package_model.dart';
import 'package:convenient_way_sender/app/data/repository/package_req.dart';
import 'package:convenient_way_sender/app/data/repository/request_model/cancel_package_model.dart';
import 'package:convenient_way_sender/app/data/repository/request_model/package_list_model.dart';
import 'package:convenient_way_sender/app/data/repository/response_model/simple_response_model.dart';
import 'package:convenient_way_sender/app/network/exceptions/base_exception.dart';

class ApprovedTabController extends BasePagingController<Package>
    with GetSingleTickerProviderStateMixin {
  final AuthController _authController = Get.find<AuthController>();
  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());

  String? reason;
  @override
  Future<void> fetchDataApi() async {
    PackageListModel requestModel = PackageListModel(
        senderId: _authController.account!.id,
        status: PackageStatus.APPROVED,
        pageIndex: pageIndex,
        pageSize: pageSize);
    Future<List<Package>> future = _packageRepo.getList(requestModel);
    await callDataService<List<Package>>(future,
        onSuccess: onSuccess, onError: onError);
  }

  Future<void> senderCancelPackage(String packageId) async {
    MaterialDialogService.showDeleteDialog(
        onConfirmTap: () {
          CancelPackageModel model = CancelPackageModel(
            packageId: packageId,
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
        msg: 'Bạn chắc chắn muốn hủy kiện hàng này');
  }
}
