import 'package:convenient_way_sender/app/data/models/feedback_model.dart';
import 'package:convenient_way_sender/app/data/models/package_cancel_model.dart';
import 'package:convenient_way_sender/app/data/models/package_count_model.dart';
import 'package:convenient_way_sender/app/data/models/package_model.dart';
import 'package:convenient_way_sender/app/data/models/suggest_package_model.dart';
import 'package:convenient_way_sender/app/data/repository/request_model/account_pickup_model.dart';
import 'package:convenient_way_sender/app/data/repository/request_model/cancel_package_model.dart';
import 'package:convenient_way_sender/app/data/repository/request_model/create_feedback_model.dart';
import 'package:convenient_way_sender/app/data/repository/request_model/create_package_model.dart';
import 'package:convenient_way_sender/app/data/repository/request_model/package_cancel_list_model.dart';
import 'package:convenient_way_sender/app/data/repository/request_model/package_list_model.dart';
import 'package:convenient_way_sender/app/data/repository/request_model/package_model/feedback_list_model.dart';
import 'package:convenient_way_sender/app/data/repository/request_model/suggest_package_request_model.dart';
import 'package:convenient_way_sender/app/data/repository/response_model/simple_response_model.dart';

import 'request_model/package_model/report_package_model.dart';

abstract class PackageReq {
  // Future<List<SuggestPackage>> getSuggestPackage(
  //     SuggestPackageRequestModel model);
  // Future<List<Package>> getList(PackageListModel model);
  // Future<Package> create(CreatePackageModel model);
  // Future<List<PackageCancel>> getListCancelReason(PackageCancelListModel model);
  // Future<SimpleResponseModel> pickUpPackage(AccountPickUpModel model);
  // Future<SimpleResponseModel> confirmPackage(String packageId);
  // Future<SimpleResponseModel> deliverySuccess(String packageId);
  // Future<SimpleResponseModel> deliveryFailed(String packageId);
  // Future<SimpleResponseModel> deliverCancel(CancelPackageModel model);
  // Future<SimpleResponseModel> senderCancel(CancelPackageModel model);
  // Future<SimpleResponseModel> senderConfirmDeliverySuccess(String packageId);
  // Future<SimpleResponseModel> senderConfirmDeliveryFailed(String packageId);
  // Future<SimpleResponseModel> refundSuccess(String packageId);
  // Future<SimpleResponseModel> refundFailed(String packageId);
  // Future<Feedback> createFeedback(CreateFeedbackModel model);

  Future<List<SuggestPackage>> getSuggestPackage(
      SuggestPackageRequestModel model);
  Future<List<Package>> getList(PackageListModel model);
  Future<Package> create(CreatePackageModel model);
  Future<List<PackageCancel>> getListCancelReason(PackageCancelListModel model);
  Future<SimpleResponseModel> pickupSuccess(String packageId);
  Future<SimpleResponseModel> deliveredSuccess(String packageId);
  Future<SimpleResponseModel> deliverCancel(CancelPackageModel model);
  Future<SimpleResponseModel> senderCancel(CancelPackageModel model);
  Future<SimpleResponseModel> refundSuccess(String packageId);
  Future<SimpleResponseModel> refundFailed(String packageId);
  Future<Feedback> createFeedback(CreateFeedbackModel model);
  Future<PackageCount> getPackageCount(String deliverId);
  Future<List<Feedback>> getFeedback(FeedbackListModel model);
  Future<SimpleResponseModel> reportPackage(ReportPackage model);
  Future<SimpleResponseModel> confirmSuccess(String packageId);
}
