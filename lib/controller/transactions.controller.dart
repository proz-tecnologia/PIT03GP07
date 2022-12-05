import 'package:belt/controller/category.controller.dart';
import 'package:belt/model/category.model.dart';
import 'package:belt/model/transaction.model.dart';
import 'package:belt/repository/category.repository_impl.dart';
import 'package:belt/repository/transaction.repository.dart';
import 'package:belt/service/api.service.dart';
import 'package:mobx/mobx.dart';

part 'transactions.controller.g.dart';

class TransactionController = TransactionControllerBase
    with _$TransactionController;

abstract class TransactionControllerBase with Store {
  final TransactionRepository _repository;

  final _controllerCategory =
      CategoryController(CategoryRepositoryImpl(APIService()));

  TransactionControllerBase(this._repository);

  @observable
  ObservableList<Transaction> _transactions = ObservableList<Transaction>();

  @observable
  bool isLoading = false;

  @action
  load() async {
    isLoading = true;
    var response = await _repository.getAll();
    for (var element in response.data!) {
      _transactions.add(element);
    }
    isLoading = false;
    _transactions.sort((a, b) => b.dateTime!.compareTo(a.dateTime!));
  }

  List<Transaction> get getAllTransaction => _transactions;

  double get getTotalIncoming {
    double value = 0;
    var filtered = _transactions
        .where((element) => element.transactionType == TransactionType.INCOME);
    for (var transaction in filtered) {
      value += transaction.value;
    }
    return value;
  }

  double get getTotalOutcoming {
    double value = 0;
    var filtered = _transactions
        .where((element) => element.transactionType == TransactionType.EXPENSE);
    for (var transaction in filtered) {
      value += transaction.value;
    }
    return value;
  }

  double get totalBalance {
    double value = getTotalIncoming - getTotalOutcoming;
    return value;
  }

  List<Category> get getListCategoryValue {
    List<Category> categorys = _controllerCategory.categorys;

    for (var element in categorys) {
      if (element.value == 0.0) {
        for (var item in _transactions) {
          if (element.name == item.category.name && item.transactionType == TransactionType.EXPENSE) {
            element.value += item.value;
          }
        }
      }
    }

    return categorys;
  }
}
