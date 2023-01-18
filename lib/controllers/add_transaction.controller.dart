import '/infra/repositories/transaction.repository.dart';
import '/models/category.model.dart';
import '/models/transaction.model.dart';
import '/stores/transactions.store.dart';
import 'package:get_it/get_it.dart';

class AddTransactionController {
  final TransactionRepository _repository;

  AddTransactionController(this._repository);

  final _store = GetIt.instance.get<TransactionsStore>();

  Future<bool> registerTransaction(
      double value, String description, DateTime date, Category category, String typeTransaction) async {
    Transaction transaction =
        Transaction(date: date, description: description, value: value, category: category,typeTransaction: typeTransaction);
    final response = await _repository.add(transaction);
    if (response.isSuccess) {
      _store.addTransaction(response.data!);
      return true;
    } else {
      return false;
    }
  }
}
