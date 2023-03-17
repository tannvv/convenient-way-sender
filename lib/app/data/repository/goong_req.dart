import 'package:convenient_way_sender/app/data/models/response_goong_default.dart';
import 'package:convenient_way_sender/app/data/models/response_goong_model.dart';
import 'package:convenient_way_sender/app/data/models/polyline_model.dart';
import 'package:convenient_way_sender/app/data/repository/request_model/request_polyline_model';

abstract class GoongReq {
  Future<List<ResponseGoong>> getList(String query);
  Future<List<ResponseGoongDefault>> getListDefault(String query);
  Future<ResponseGoong> getDetail(String placeId);
  Future<List<PolylineModel>> getPolyline(RequestPolylineModel model);
}
