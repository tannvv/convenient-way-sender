import 'package:convenient_way_sender/app/data/models/transaction_model.dart';
import 'package:convenient_way_sender/app/data/repository/request_model/transaction_list_model.dart';

abstract class TransactionReq {
  Future<Transaction> getId(String id);
  Future<List<Transaction>> getList(TransactionListModel model);
}
