import 'package:convenient_way_sender/app/data/repository/request_model/vnpay_url_model.dart';

abstract class VnPayReq {
  Future<String> getVnPayUrl(VnpayUrlModel model);
}
