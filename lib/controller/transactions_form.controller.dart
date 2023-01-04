import 'package:belt/model/api_response.model.dart';
import 'package:belt/model/category.model.dart';
import 'package:belt/model/transaction.model.dart';
import 'package:belt/repository/transaction.repository.dart';
import 'package:mobx/mobx.dart';

part 'transactions_form.controller.g.dart';

class TransactionFormController = TransactionFormControllerBase
    with _$TransactionFormController;

abstract class TransactionFormControllerBase with Store {
  final TransactionRepository _repository;

  TransactionFormControllerBase(this._repository);

  Transaction transaction =
      Transaction(category: Category(name: 'Alimentação'));

  @action
  saveValue(String? newValue) {
    transaction.value =
        double.parse(newValue!.replaceAll('.', '').replaceAll(',', '.'));
  }

  @action
  saveDescription(String? newValue) {
    transaction.description = newValue;
  }

  @action
  saveData(String? newValue) {
    transaction.dateTime = DateTime.parse(newValue!);
  }

  @action
  saveCategory(Category newValue) {
    transaction.category = newValue;
  }

  @action 
  saveTransactionType(TransactionType newValue){
    transaction.transactionType = newValue;
  }

  @action
  reset() {
    transaction = Transaction(category: Category(name: 'Alimentação'));
  }

  String? validateValue(String? newValue) {
    if (newValue!.isEmpty) return "Informe um valor.";
    final valueDouble =
        double.parse(newValue.replaceAll('.', '').replaceAll(',', '.'));
    if (valueDouble == 0) return "Informe um valor diferente de 0";
    return null;
  }

  String? validateDescription(String? newValue) {
    if (newValue!.length == 1 || newValue.length > 30) {
      return "Campo deve ter ao menos 3 e no máximo 30 caractéres.";
    }
    return null;
  }

  String? validateDate(String? newValue) {
    if (newValue!.isEmpty) {
      return "Informe uma data.";
    }
    return null;
  }

  String? validateSelect(Category? newValue) {
    if (newValue == null) {
      return "Selecione uma categoria.";
    }
    return null;
  }

  Future<APIResponse<Transaction>> save() async {
    return await _repository.add(transaction);
  }
}
