import '/infra/repositories/transaction.repository.dart';
import '/infra/services/transaction.service.dart';
import '/models/transaction.model.dart';
import '/models/api_response.model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionService _service;

  TransactionRepositoryImpl(this._service);

  @override
  Future<APIResponse<Transaction>> add(Transaction item) async {
    final docRef = await _service.add(item.toMap());
    item.uid = docRef.id;

    return APIResponse.success(item);
  }

  @override
  Future<APIResponse<List<Transaction>>> getMonth(DateTime dateSelected) async {
    final querySnapshot = await _service.getByMonth(dateSelected);
    List<Transaction> listTransactions = [];
    for (var doc in querySnapshot.docs) {
      Transaction item =
          Transaction.fromFirestore(doc.data() as Map<String, dynamic>);
      item.uid = doc.id;
      listTransactions.add(item);
    }
    return APIResponse.success(listTransactions);
  }

  @override
  Future<APIResponse<bool>> remove(Transaction item) async {
    final result = await _service.remove(item.uid!);
    if (result) {
      return APIResponse.success(result);
    } else {
      return APIResponse.error("Operação falhou!");
    }
  }

  @override
  Future<APIResponse<bool>> update(Transaction item) async {
    throw UnimplementedError();
  }
}
