import '/infra/repositories/category.repository.dart';
import '/infra/repositories/transaction.repository.dart';
import '/models/api_response.model.dart';
import '/models/category.model.dart';
import '/models/transaction.model.dart';
import '/stores/category.store.dart';
import '/stores/transactions.store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'home.controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  final TransactionRepository _transactionRepository;
  final CategoryRepository _categoryRepository;

  HomeControllerBase(this._transactionRepository, this._categoryRepository) {
    _currentDateTime = DateTime.now();
    _currentDateTime = DateTime(
        _currentDateTime.year, _currentDateTime.month, _currentDateTime.day);
  }

  @readonly
  DateTime _currentDateTime = DateTime.now();

  @readonly
  bool _isLoading = false;

  @action
  increaseMonth() async {
    _isLoading = true;
    _currentDateTime = _currentDateTime.add(const Duration(days: 31));
    await getList();
    _isLoading = false;
  }

  @action
  decreaseMonth() async {
    _isLoading = true;
    _currentDateTime = _currentDateTime.subtract(const Duration(days: 31));
    await getList();
    _isLoading = false;
  }

  Future<APIResponse<List<Transaction>>> getList() async {
    final response = await _transactionRepository.getMonth(_currentDateTime);
    if (response.isSuccess) {
      final store = GetIt.instance.get<TransactionsStore>();
      store.replaceList(response.data!);
    }
    return response;
  }
  Future<APIResponse<List<Category>>> getListCategory() async {
    final response = await _categoryRepository.getAllCatecorys();
    if (response.isSuccess) {
      final store = GetIt.instance.get<CategoryStore>();
      store.replaceList(response.data!);
    }
    return response;
  }

  Future<double> getTotalTransactions()async {
    double value = 0;
    var response = await getList();
    print(response);
    return value;
  }

  Future<APIResponse<bool>> removeTransaction(Transaction item) async {
    final response = await _transactionRepository.remove(item);
    if (response.isSuccess) {
      final store = GetIt.instance.get<TransactionsStore>();
      store.removeTransaction(item);
    }
    return response;
  }
}
