import '/models/category.model.dart';
import 'package:get_it/get_it.dart';

import '../infra/repositories/category.repository.dart';
import '../stores/category.store.dart';

class AddCategoryController {
  final CategoryRepository _repository;

  AddCategoryController(this._repository);

  final _store = GetIt.instance.get<CategoryStore>();

  Future<bool> registerTransaction(String name, String typeTransaction) async {
    Category category =
        Category(name: name, typeTransaction: typeTransaction);
    final response = await _repository.add(category);
    if (response.isSuccess) {
      _store.addTransaction(response.data!);
      return true;
    } else {
      return false;
    }
  }
}