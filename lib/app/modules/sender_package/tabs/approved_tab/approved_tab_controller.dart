import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:convenient_way_sender/app/core/utils/material_dialog_service.dart';
import 'package:get/get.dart';
import 'package:convenient_way_sender/app/core/base/base_paging_controller.dart';
import 'package:convenient_way_sender/app/core/controllers/auth_controller.dart';
import 'package:convenient_way_sender/app/core/utils/toast_service.dart';
import 'package:convenient_way_sender/app/data/constants/package_status.dart';
import 'package:convenient_way_sender/app/data/models/package_model.dart';
import 'package:convenient_way_sender/app/data/repository/package_req.dart';
import 'package:convenient_way_sender/app/data/repository/request_model/cancel_package_model.dart';
import 'package:convenient_way_sender/app/data/repository/request_model/package_list_model.dart';
class ApprovedTabController extends BasePagingController<Package>
    with GetSingleTickerProviderStateMixin {
  final AuthController _authController = Get.find<AuthController>();
  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());

  @override
  void onInit() {
    super.onInit();
    onListeningChange();
  }

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

  void onListeningChange() {
    FirebaseMessaging.onMessage.listen((event) {
      if(event.notification?.title == "Kiện hàng đã được nhận"){
        onRefresh();
      }
    });
  }
  
}
