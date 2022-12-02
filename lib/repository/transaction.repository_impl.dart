import 'package:belt/model/api_response.model.dart';
import 'package:belt/model/transaction.model.dart';
import 'package:belt/repository/transaction.repository.dart';
import 'package:belt/service/api.service.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  final APIService _apiService;

  TransactionRepositoryImpl(this._apiService);

  @override
  Future<APIResponse<Transaction>> add(Transaction item) async {
    try {
      final response = await _apiService.addTransaction(item);
      if (response.statusCode == 201) {
        final dataObject = Map<String, dynamic>.from(response.data);
        final item = Transaction.fromJson(dataObject);
        return APIResponse.success(item);
      } else {
        return APIResponse.error("Ops! Ocorreu uma falha na operação, tente novamente em breve!");
      }
    } on Exception catch (e) {
      return APIResponse.error(e.toString());
    }
  }

  @override
  Future<APIResponse> delete(Transaction item) async {
    try {
      final response = await _apiService.deleteTransaction(item);
      if (response.statusCode == 200) {
        return APIResponse.success(null);
      } else {
        return APIResponse.error("Ops! Item não encontrado!");
      }
    } on Exception catch (e) {
      return APIResponse.error(e.toString());
    }
  }

  @override
  Future<APIResponse<List<Transaction>>> getAll() async {
    try {
      final response = await _apiService.getAllTransaction();
      if (response.statusCode == 200) {
        final dataObject = List<Map<String, dynamic>>.from(response.data);
        List<Transaction> items = [];
        for (var element in dataObject) {
          items.add(Transaction.fromJson(element));
        }
        return APIResponse.success(items);
      } else {
        return APIResponse.error("Ops! Ocorreu uma falha na operação, tente novamente em breve!");
      }
    } on Exception catch (e) {
      return APIResponse.error(e.toString());
    }
  }

  @override
  Future<APIResponse<Transaction>> getById(String id) async {
    try {
      final response = await _apiService.getByIdTransaction(id);
      if (response.statusCode == 200) {
        final dataObject = Map<String, dynamic>.from(response.data);
        final item = Transaction.fromJson(dataObject);
        return APIResponse.success(item);
      } else {
        return APIResponse.error("Ops! Item não encontrado!");
      }
    } on Exception catch (e) {
      return APIResponse.error(e.toString());
    }
  }

  @override
  Future<APIResponse> update(Transaction item) async {
    try {
      final response = await _apiService.updateTransaction(item);
      if (response.statusCode == 200) {
        return APIResponse.success(null);
      } else {
        return APIResponse.error("Ops! Ocorreu uma falha na operação, tente novamente em breve!");
      }
    } on Exception catch (e) {
      return APIResponse.error(e.toString());
    }
  }
}
