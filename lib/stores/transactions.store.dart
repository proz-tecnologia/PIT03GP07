import '/models/transaction.model.dart';
import 'package:mobx/mobx.dart';

part 'transactions.store.g.dart';

class TransactionsStore = TransactionsStoreBase with _$TransactionsStore;

abstract class TransactionsStoreBase with Store {
  final ObservableList<Transaction> list = ObservableList();

  @computed
  int get count => list.length;

  double totalTransactions() {
    double value = 0;
    for (var element in list) {
      value += element.value;
    }
    return value;
  }

  @action
  replaceList(List<Transaction> transactions) {
    list.clear();
    list.addAll(transactions);
    sortOrder();
  }

  @action
  addTransaction(Transaction transaction) {
    list.add(transaction);
    sortOrder();
  }

  @action
  removeTransaction(Transaction transaction) {
    list.removeWhere((e) => e.uid == transaction.uid);
    sortOrder();
  }

  sortOrder() {
    list.sort((a, b) => b.date!.compareTo(a.date!));
  }
}
