import 'package:convenient_way_sender/app/core/base/base_repository.dart';
import 'package:convenient_way_sender/app/data/models/polyline_model.dart';
import 'package:convenient_way_sender/app/data/models/response_goong_default.dart';
import 'package:convenient_way_sender/app/data/models/response_goong_model.dart';
import 'package:convenient_way_sender/app/data/repository/goong_req.dart';
import 'package:convenient_way_sender/app/data/repository/request_model/request_polyline_model.dart';
import 'package:convenient_way_sender/app/network/dio_provider.dart';

class GoongReqImp extends BaseRepository implements GoongReq {
  @override
  Future<List<ResponseGoong>> getList(String query) {
    String endpoint = '${DioProvider.baseUrl}/goongs';
    var dioCall = dioClient.get(endpoint, queryParameters: {'search': query});
    try {
      return callApi(dioCall).then((response) {
        List<ResponseGoong> data = (response.data['data'] as List)
            .map((e) => ResponseGoong.fromJson(e))
            .toList();
        return data;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PolylineModel>> getPolyline(RequestPolylineModel model) {
    String endpoint = '${DioProvider.baseUrl}/mapboxs/poly-line';
    var dioCall = dioClient.post(endpoint, data: model.toJson());
    try {
      return callApi(dioCall).then((response) {
        List<PolylineModel> data = (response.data['data'] as List)
            .map((e) => PolylineModel.fromJson(e))
            .toList();
        return data;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResponseGoong> getDetail(String placeId) {
    String endpoint = '${DioProvider.baseUrl}/goongs/detail';
    var dioCall =
        dioClient.get(endpoint, queryParameters: {'placeId': placeId});
    try {
      return callApi(dioCall).then((response) {
        ResponseGoong data = ResponseGoong.fromJson(response.data['data']);
        return data;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ResponseGoongDefault>> getListDefault(String query) {
    String endpoint = '${DioProvider.baseUrl}/goongs/search-default';
    var dioCall = dioClient.get(endpoint, queryParameters: {'search': query});
    try {
      return callApi(dioCall).then((response) {
        List<ResponseGoongDefault> data = (response.data['data'] as List)
            .map((e) => ResponseGoongDefault.fromJson(e))
            .toList();
        return data;
      });
    } catch (e) {
      rethrow;
    }
  }
}
