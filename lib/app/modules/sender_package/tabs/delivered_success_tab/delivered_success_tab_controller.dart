import 'package:get/get.dart';
import 'package:convenient_way_sender/app/core/base/sender_tab_base_controller.dart';
import 'package:convenient_way_sender/app/core/controllers/auth_controller.dart';
import 'package:convenient_way_sender/app/core/utils/material_dialog_service.dart';
import 'package:convenient_way_sender/app/core/utils/toast_service.dart';
import 'package:convenient_way_sender/app/data/constants/package_status.dart';
import 'package:convenient_way_sender/app/data/models/package_model.dart';
import 'package:convenient_way_sender/app/data/repository/package_req.dart';
import 'package:convenient_way_sender/app/data/repository/request_model/package_list_model.dart';
import 'package:convenient_way_sender/app/data/repository/response_model/simple_response_model.dart';
import 'package:convenient_way_sender/app/routes/app_pages.dart';

class DeliveredSuccessTabController extends SenderTabBaseController<Package>
    with GetSingleTickerProviderStateMixin {
  final AuthController _authController = Get.find<AuthController>();
  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());

  @override
  Future<void> fetchDataApi() async {
    PackageListModel requestModel = PackageListModel(
        senderId: _authController.account!.id,
        status: PackageStatus.DELIVERED_SUCCESS,
        pageIndex: pageIndex,
        pageSize: pageSize);
    Future<List<Package>> future = _packageRepo.getList(requestModel);
    await callDataService<List<Package>>(future,
        onSuccess: onSuccess, onError: onError);
  }

  Future<void> confirmFailed(String packageId) async {
    // Tạo màn hình riêng
    MaterialDialogService.showDeleteDialog(
        msg: 'Bạn có chắc là muốn báo xấu gói hàng này?',
        onConfirmTap: () {
          Get.toNamed(Routes.REPORT_PACKAGE);
          onRefresh();
          // var future = _packageRepo.senderConfirmDeliveryFailed(packageId);
          // callDataService<SimpleResponseModel>(
          //   future,
          //   onSuccess: (_) {
          //     ToastService.showSuccess('Cập nhật thành công');
          //   },
          //   onError: showError,
          //   onStart: showOverlay,
          //   onComplete: hideOverlay,
          // );
        });
  }

  Future<void> confirmSuccess(String packageId) async {
    MaterialDialogService.showConfirmDialog(onConfirmTap: () {
      var future = _packageRepo.confirmSuccess(packageId);
      callDataService<SimpleResponseModel>(
        future,
        onSuccess: (_) {
          ToastService.showSuccess('Xác nhận thành công');
        },
        onError: showError,
        onStart: showOverlay,
        onComplete: hideOverlay,
      );
    });
  }

  Future<void> sendFeedback(Package package) async {
    await Get.toNamed(Routes.FEEDBACK_FOR_DELIVER, arguments: package);
  }
}
