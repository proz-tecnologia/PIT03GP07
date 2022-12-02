import 'package:belt/model/api_response.model.dart';
import 'package:belt/model/transaction.model.dart';



abstract class TransactionRepository {
  Future<APIResponse<List<Transaction>>> getAll();
  Future<APIResponse<Transaction>> add(Transaction item);
  Future<APIResponse<Transaction>> getById(String id);
  Future<APIResponse> update(Transaction item);
  Future<APIResponse> delete(Transaction item);
}