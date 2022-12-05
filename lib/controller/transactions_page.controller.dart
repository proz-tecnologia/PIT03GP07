import 'package:belt/model/transaction.model.dart';
import 'package:mobx/mobx.dart';

part 'transactions_page.controller.g.dart';

class TransactionPageController = TransactionPageControllerBase with _$TransactionPageController;

abstract class TransactionPageControllerBase with Store {
  final List<Transaction> _transactions;
  TransactionPageControllerBase(this._transactions);

  var _transactionsList = ObservableList<Transaction>();

  @observable
  String titlePopup = "Transações";

  List<Transaction> get getAllTransaction => _transactionsList;

  @action 
  loadListTransactions() {
    var response = _transactions;
    for (var element in response) {
      _transactionsList.add(element);
    }
  }


  @action 
  setTitlePopup (String title, TransactionType type) {
    if(type == TransactionType.INCOME) {
      _transactionsList = ObservableList<Transaction>();
      titlePopup = title;
      loadListTransactions();
      var filtred = _transactionsList.where((element) => element.transactionType == TransactionType.INCOME);
      _transactionsList = ObservableList<Transaction>();
      for (var element in filtred) {
        _transactionsList.add(element);
      }
    }
    if(type == TransactionType.EXPENSE) {
      _transactionsList = ObservableList<Transaction>();
      titlePopup = title;
      loadListTransactions();
      var filtred = _transactionsList.where((element) => element.transactionType == TransactionType.EXPENSE).toList();
      _transactionsList = ObservableList<Transaction>();
      for (var element in filtred) {
        _transactionsList.add(element);
      }
    }
    if(type == TransactionType.TRANSACTIONS) {
      titlePopup = title;
      _transactionsList = ObservableList<Transaction>();
      loadListTransactions();
    }
  }
}