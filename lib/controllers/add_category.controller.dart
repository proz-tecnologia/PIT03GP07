import '../models/api_response.model.dart';
import '/models/category.model.dart';
import 'package:get_it/get_it.dart';

import '../infra/repositories/category.repository.dart';
import '../stores/category.store.dart';

class AddCategoryController {
  final CategoryRepository _repository;
  final CategoryRepository _categoryRepository;

  AddCategoryController(this._repository, this._categoryRepository);

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

  Future<APIResponse<List<Category>>> getListCategory() async {
    final response = await _categoryRepository.getAllCatecorys();
    if (response.isSuccess) {
      final store = GetIt.instance.get<CategoryStore>();
      store.replaceList(response.data!);
    }
    return response;
  }
}