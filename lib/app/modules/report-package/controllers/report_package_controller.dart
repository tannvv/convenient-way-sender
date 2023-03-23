import 'package:convenient_way_sender/app/core/controllers/pickup_file_controller.dart';
import 'package:convenient_way_sender/app/core/utils/material_dialog_service.dart';
import 'package:convenient_way_sender/app/core/utils/toast_service.dart';
import 'package:convenient_way_sender/app/core/widgets/custom_overlay.dart';
import 'package:convenient_way_sender/app/data/models/package_model.dart';
import 'package:convenient_way_sender/app/data/repository/package_req.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:uuid/uuid.dart';

class ReportPackageController extends GetxController {
  Package package = Get.arguments as Package;

  final PickUpFileController _pickUpFileController =
      Get.find<PickUpFileController>();
  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());

  TextEditingController reasonController = TextEditingController();
  final GlobalKey<FormFieldState> reasonFieldKey = GlobalKey<FormFieldState>();
  final FocusNode reasonFocusNode = FocusNode();

  final imagesController = MultiImagePickerController(
    maxImages: 10,
    withReadStream: true,
    allowedImageTypes: ['png', 'jpg', 'jpeg'],
  );
  Iterable<ImageFile> images = [];

  Future<void> onReportPackage() async {
    if (images.isEmpty || !reasonFieldKey.currentState!.validate()) {
      ToastService.showError('Vui lòng chọn ảnh');
      return;
    }

    MaterialDialogService.showDeleteDialog(
        title: 'Xác nhận',
        msg: 'Bạn chắc chắn muốn hủy gói hàng này?',
        onConfirmTap: () async {
          String urlImages = 'transactions-packages/${const Uuid().v4()}';

          List<String> urlsImage =
              await _pickUpFileController.uploadImagesToFirebase2(
            images: images,
            url: urlImages,
            onComplete: Get.context!.loaderOverlay.hide,
            onStart: () => Get.context!.loaderOverlay.show(
                widget: const CustomOverlay(
              content: 'Đang tải ảnh lên...',
            )),
          );
          if (urlsImage.isEmpty) return;

          // PickupPackageFailedModel model = PickupPackageFailedModel(
          //     packageId: package.id,
          //     reason: reasonController.text,
          //     imageUrl: urlImages);
          // var future = _packageRepo.pickupFailed(model);
          // callDataService(future, onSuccess: (data) {
          //   ToastService.showSuccess('Báo cáo sự cố thành công');
          //   Get.back(); // return waiting screen
          // }, onError: showError, onComplete: hideOverlay);
        });
  }

  void initFocusNode() {
    reasonFocusNode.addListener(() {
      if (reasonFocusNode.hasFocus) {
        reasonFieldKey.currentState!.validate();
      }
    });
  }
}
