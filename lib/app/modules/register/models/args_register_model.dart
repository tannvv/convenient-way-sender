import 'package:convenient_way_sender/app/data/repository/request_model/create_account_model.dart';

class ArgsRegisterModel {
  String verificationId;
  int? resendToken;
  CreateAccountModel createAccountModel;

  ArgsRegisterModel(
      {required this.verificationId,
      this.resendToken,
      required this.createAccountModel});
}
