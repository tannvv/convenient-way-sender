import 'package:convenient_way_sender/app/core/base/base_repository.dart';
import 'package:convenient_way_sender/app/data/models/feedback_model.dart';
import 'package:convenient_way_sender/app/data/models/package_cancel_model.dart';
import 'package:convenient_way_sender/app/data/models/package_count_model.dart';
import 'package:convenient_way_sender/app/data/models/package_model.dart';
import 'package:convenient_way_sender/app/data/models/suggest_package_model.dart';
import 'package:convenient_way_sender/app/data/repository/package_req.dart';
import 'package:convenient_way_sender/app/data/repository/request_model/cancel_package_model.dart';
import 'package:convenient_way_sender/app/data/repository/request_model/create_feedback_model.dart';
import 'package:convenient_way_sender/app/data/repository/request_model/create_package_model.dart';
import 'package:convenient_way_sender/app/data/repository/request_model/package_list_model.dart';
import 'package:convenient_way_sender/app/data/repository/request_model/package_cancel_list_model.dart';
import 'package:convenient_way_sender/app/data/repository/request_model/package_model/feedback_list_model.dart';
import 'package:convenient_way_sender/app/data/repository/request_model/package_model/report_package_model.dart';
import 'package:convenient_way_sender/app/data/repository/request_model/suggest_package_request_model.dart';
import 'package:convenient_way_sender/app/data/repository/response_model/simple_response_model.dart';
import 'package:convenient_way_sender/app/network/dio_provider.dart';

class PackageReqImp extends BaseRepository implements PackageReq {
  @override
  Future<List<SuggestPackage>> getSuggestPackage(
      SuggestPackageRequestModel model) {
    String endpoint = '${DioProvider.baseUrl}/packages/combos-v2';
    Map<String, dynamic> queryParams = model.toJson();
    var dioCall = dioClient.get(endpoint, queryParameters: queryParams);
    try {
      return callApi(dioCall).then((response) {
        List<SuggestPackage> data = (response.data['data'] as List)
            .map((e) => SuggestPackage.fromJson(e))
            .toList();
        return data;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Package>> getList(PackageListModel model) {
    String endpoint = '${DioProvider.baseUrl}/packages';
    Map<String, dynamic> queryParams = model.toJson();
    var dioCall = dioClient.get(endpoint, queryParameters: queryParams);
    try {
      return callApi(dioCall).then((response) {
        List<Package> data = (response.data['data'] as List)
            .map((e) => Package.fromJson(e))
            .toList();
        return data;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PackageCancel>> getListCancelReason(
      PackageCancelListModel model) {
    String endpoint =
        '${DioProvider.baseUrl}/transactionpackages/cancel-package';
    Map<String, dynamic> queryParams = model.toJson();
    var dioCall = dioClient.get(endpoint, queryParameters: queryParams);
    try {
      return callApi(dioCall).then((response) {
        List<PackageCancel> data = (response.data['data'] as List)
            .map((e) => PackageCancel.fromJson(e))
            .toList();
        return data;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SimpleResponseModel> pickupSuccess(String packageId) {
    String endpoint = '${DioProvider.baseUrl}/packages/pickup-success';
    var dioCall =
        dioClient.put(endpoint, queryParameters: {'packageId': packageId});
    try {
      return callApi(dioCall)
          .then((response) => SimpleResponseModel.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SimpleResponseModel> deliverCancel(CancelPackageModel model) {
    String endpoint = '${DioProvider.baseUrl}/packages/deliver-cancel';
    var dioCall = dioClient.put(endpoint, data: model.toJson());
    try {
      return callApi(dioCall)
          .then((response) => SimpleResponseModel.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Package> create(CreatePackageModel model) {
    String endpoint = '${DioProvider.baseUrl}/packages';
    var dioCall = dioClient.post(endpoint, data: model.toJson());
    try {
      return callApi(dioCall).then((response) {
        Package data = Package.fromJson(response.data['data']);
        return data;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SimpleResponseModel> senderCancel(CancelPackageModel model) {
    String endpoint = '${DioProvider.baseUrl}/packages/sender-cancel';
    var dioCall = dioClient.put(endpoint, data: model.toJson());
    try {
      return callApi(dioCall)
          .then((response) => SimpleResponseModel.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Feedback> createFeedback(CreateFeedbackModel model) async {
    String endpoint = '${DioProvider.baseUrl}/feedbacks';
    var dioCall = dioClient.post(endpoint, data: model.toJson());
    try {
      return callApi(dioCall).then((response) {
        Feedback data = Feedback.fromJson(response.data['data']);
        return data;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SimpleResponseModel> refundFailed(String packageId) {
    String endpoint = '${DioProvider.baseUrl}/packages/refund-failed';
    var dioCall =
        dioClient.put(endpoint, queryParameters: {'packageId': packageId});
    try {
      return callApi(dioCall)
          .then((response) => SimpleResponseModel.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SimpleResponseModel> refundSuccess(String packageId) {
    String endpoint = '${DioProvider.baseUrl}/packages/refund-success';
    var dioCall =
        dioClient.put(endpoint, queryParameters: {'packageId': packageId});
    try {
      return callApi(dioCall)
          .then((response) => SimpleResponseModel.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SimpleResponseModel> deliveredSuccess(String packageId) {
    String endpoint = '${DioProvider.baseUrl}/packages/delivered-success';
    var dioCall =
        dioClient.put(endpoint, queryParameters: {'packageId': packageId});
    try {
      return callApi(dioCall)
          .then((response) => SimpleResponseModel.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PackageCount> getPackageCount(String deliverId) {
    String endpoint = '${DioProvider.baseUrl}/dashboards/package-count';
    var dioCall =
        dioClient.get(endpoint, queryParameters: {'deliverId': deliverId});
    try {
      return callApi(dioCall)
          .then((response) => PackageCount.fromJson(response.data['data']));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Feedback>> getFeedback(FeedbackListModel model) {
    String endpoint = '${DioProvider.baseUrl}/feedbacks';
    Map<String, dynamic> queryParams = model.toJson();
    var dioCall = dioClient.get(endpoint, queryParameters: queryParams);
    try {
      return callApi(dioCall).then((response) {
        List<Feedback> data = (response.data['data'] as List)
            .map((e) => Feedback.fromJson(e))
            .toList();
        return data;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SimpleResponseModel> reportPackage(ReportPackage model) {
    String endpoint = '${DioProvider.baseUrl}/packages/report-problem';
    var dioCall = dioClient.put(endpoint, data: model.toJson());
    try {
      return callApi(dioCall)
          .then((response) => SimpleResponseModel.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SimpleResponseModel> confirmSuccess(String packageId) {
    String endpoint = '${DioProvider.baseUrl}/packages/confirm-success';
    var dioCall =
        dioClient.put(endpoint, queryParameters: {'packageId': packageId});
    try {
      return callApi(dioCall)
          .then((response) => SimpleResponseModel.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }
  // @override
  // Future<List<SuggestPackage>> getSuggestPackage(
  //     SuggestPackageRequestModel model) {
  //   String endpoint = '${DioProvider.baseUrl}/packages/combos-v2';
  //   Map<String, dynamic> queryParams = model.toJson();
  //   var dioCall = dioClient.get(endpoint, queryParameters: queryParams);
  //   try {
  //     return callApi(dioCall).then((response) {
  //       List<SuggestPackage> data = (response.data['data'] as List)
  //           .map((e) => SuggestPackage.fromJson(e))
  //           .toList();
  //       return data;
  //     });
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<List<Package>> getList(PackageListModel model) {
  //   String endpoint = '${DioProvider.baseUrl}/packages';
  //   Map<String, dynamic> queryParams = model.toJson();
  //   var dioCall = dioClient.get(endpoint, queryParameters: queryParams);
  //   try {
  //     return callApi(dioCall).then((response) {
  //       List<Package> data = (response.data['data'] as List)
  //           .map((e) => Package.fromJson(e))
  //           .toList();
  //       return data;
  //     });
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<List<PackageCancel>> getListDeliverCancel(
  //     PackageCancelListModel model) {
  //   String endpoint =
  //       '${DioProvider.baseUrl}/transactionpackages/deliver-cancel';
  //   Map<String, dynamic> queryParams = model.toJson();
  //   var dioCall = dioClient.get(endpoint, queryParameters: queryParams);
  //   try {
  //     return callApi(dioCall).then((response) {
  //       List<PackageCancel> data = (response.data['data'] as List)
  //           .map((e) => PackageCancel.fromJson(e))
  //           .toList();
  //       return data;
  //     });
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<List<PackageCancel>> getListCancelReason(
  //     PackageCancelListModel model) {
  //   String endpoint =
  //       '${DioProvider.baseUrl}/transactionpackages/cancel-package';
  //   Map<String, dynamic> queryParams = model.toJson();
  //   var dioCall = dioClient.get(endpoint, queryParameters: queryParams);
  //   try {
  //     return callApi(dioCall).then((response) {
  //       List<PackageCancel> data = (response.data['data'] as List)
  //           .map((e) => PackageCancel.fromJson(e))
  //           .toList();
  //       return data;
  //     });
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<SimpleResponseModel> pickUpPackage(AccountPickUpModel model) async {
  //   String endpoint = '${DioProvider.baseUrl}/packages/deliver-pickup';
  //   var dioCall = dioClient.put(endpoint, data: model.toJson());
  //   try {
  //     return callApi(dioCall)
  //         .then((response) => SimpleResponseModel.fromJson(response.data));
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<SimpleResponseModel> deliveryFailed(String packageId) {
  //   String endpoint = '${DioProvider.baseUrl}/packages/delivery-failed';
  //   var dioCall =
  //       dioClient.put(endpoint, queryParameters: {'packageId': packageId});
  //   try {
  //     return callApi(dioCall)
  //         .then((response) => SimpleResponseModel.fromJson(response.data));
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<SimpleResponseModel> deliverySuccess(String packageId) {
  //   String endpoint = '${DioProvider.baseUrl}/packages/delivered-success';
  //   var dioCall =
  //       dioClient.put(endpoint, queryParameters: {'packageId': packageId});
  //   try {
  //     return callApi(dioCall)
  //         .then((response) => SimpleResponseModel.fromJson(response.data));
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<SimpleResponseModel> confirmPackage(String packageId) {
  //   String endpoint = '${DioProvider.baseUrl}/packages/pickup-success';
  //   var dioCall =
  //       dioClient.put(endpoint, queryParameters: {'packageId': packageId});
  //   try {
  //     return callApi(dioCall)
  //         .then((response) => SimpleResponseModel.fromJson(response.data));
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<SimpleResponseModel> deliverCancel(CancelPackageModel model) {
  //   String endpoint = '${DioProvider.baseUrl}/packages/deliver-cancel';
  //   var dioCall = dioClient.put(endpoint, data: model.toJson());
  //   try {
  //     return callApi(dioCall)
  //         .then((response) => SimpleResponseModel.fromJson(response.data));
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<Package> create(CreatePackageModel model) {
  //   String endpoint = '${DioProvider.baseUrl}/packages';
  //   var dioCall = dioClient.post(endpoint, data: model.toJson());
  //   try {
  //     return callApi(dioCall).then((response) {
  //       Package data = Package.fromJson(response.data['data']);
  //       return data;
  //     });
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<SimpleResponseModel> senderCancel(CancelPackageModel model) {
  //   String endpoint = '${DioProvider.baseUrl}/packages/sender-cancel';
  //   var dioCall = dioClient.put(endpoint, data: model.toJson());
  //   try {
  //     return callApi(dioCall)
  //         .then((response) => SimpleResponseModel.fromJson(response.data));
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<Feedback> createFeedback(CreateFeedbackModel model) async {
  //   String endpoint = '${DioProvider.baseUrl}/feedbacks';
  //   var dioCall = dioClient.post(endpoint, data: model.toJson());
  //   try {
  //     return callApi(dioCall).then((response) {
  //       Feedback data = Feedback.fromJson(response.data['data']);
  //       return data;
  //     });
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<SimpleResponseModel> refundFailed(String packageId) {
  //   String endpoint = '${DioProvider.baseUrl}/packages/refund-failed';
  //   var dioCall =
  //       dioClient.put(endpoint, queryParameters: {'packageId': packageId});
  //   try {
  //     return callApi(dioCall)
  //         .then((response) => SimpleResponseModel.fromJson(response.data));
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<SimpleResponseModel> refundSuccess(String packageId) {
  //   String endpoint = '${DioProvider.baseUrl}/packages/refund-success';
  //   var dioCall =
  //       dioClient.put(endpoint, queryParameters: {'packageId': packageId});
  //   try {
  //     return callApi(dioCall)
  //         .then((response) => SimpleResponseModel.fromJson(response.data));
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<SimpleResponseModel> senderConfirmDeliverySuccess(String packageId) {
  //   String endpoint =
  //       '${DioProvider.baseUrl}/packages/sender-confirm-delivery-success';
  //   var dioCall =
  //       dioClient.put(endpoint, queryParameters: {'packageId': packageId});
  //   try {
  //     return callApi(dioCall)
  //         .then((response) => SimpleResponseModel.fromJson(response.data));
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<SimpleResponseModel> senderConfirmDeliveryFailed(String packageId) {
  //   String endpoint =
  //       '${DioProvider.baseUrl}/packages/sender-confirm-delivery-failed';
  //   var dioCall =
  //       dioClient.put(endpoint, queryParameters: {'packageId': packageId});
  //   try {
  //     return callApi(dioCall)
  //         .then((response) => SimpleResponseModel.fromJson(response.data));
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
