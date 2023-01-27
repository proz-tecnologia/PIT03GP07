import '/infra/repositories/category.repository.dart';
import '/infra/repositories/transaction.repository.dart';
import '/models/api_response.model.dart';
import '/models/category.model.dart';
import '/models/transaction.model.dart';
import '/stores/category.store.dart';
import '/stores/transactions.store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'transactions.controller.g.dart';

class TransactionsController = TransactionsControllerBase with _$TransactionsController;

abstract class TransactionsControllerBase with Store {
  final TransactionRepository _transactionRepository;
  final CategoryRepository _categoryRepository;

  TransactionsControllerBase(this._transactionRepository, this._categoryRepository) {
    _currentDateTime = DateTime.now();
    _currentDateTime = DateTime(
        _currentDateTime.year, _currentDateTime.month, _currentDateTime.day);
  }

  @observable
  String titlePopup = "Transações";

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

  @action
  setTitlePopup(String title, String type) {
    if (type == "Transações") {
      titlePopup = title;
      getList();
    }
    if (type == "Receitas") {
      titlePopup = title;
      getOnlyIncome();
    }
    if (type == "Despesas") {
      titlePopup = title;
      getOnlyExpen();
    }
  }

  @action
  editTitle() {
    titlePopup = "Transações";
    getList();
  }

  Future<APIResponse<List<Transaction>>> getList() async {
    final response = await _transactionRepository.getMonth(_currentDateTime);
    if (response.isSuccess) {
      final store = GetIt.instance.get<TransactionsStore>();
      store.replaceList(response.data!);
    }
    return response;
  }

  Future<APIResponse<List<Transaction>>> getOnlyIncome() async {
    final response = await _transactionRepository.getMonth(_currentDateTime);
    if (response.isSuccess) {
      final store = GetIt.instance.get<TransactionsStore>();
      store.replaceList(response.data!.where((element) => element.typeTransaction == "INCOME").toList());
    }
    return response;
  }

  Future<APIResponse<List<Transaction>>> getOnlyExpen() async {
    final response = await _transactionRepository.getMonth(_currentDateTime);
    if (response.isSuccess) {
      final store = GetIt.instance.get<TransactionsStore>();
      store.replaceList(response.data!.where((element) => element.typeTransaction == "EXPENSE").toList());
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
