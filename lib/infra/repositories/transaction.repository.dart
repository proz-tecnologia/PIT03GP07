import '/models/api_response.model.dart';
import '/models/transaction.model.dart';

abstract class TransactionRepository {
  Future<APIResponse<List<Transaction>>> getMonth(DateTime dateSelected);
  Future<APIResponse<Transaction>> add(Transaction item);
  Future<APIResponse<bool>> update(Transaction item);
  Future<APIResponse<bool>> remove(Transaction item);
}
