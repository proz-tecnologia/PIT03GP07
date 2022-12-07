import 'package:belt/model/category.model.dart';
import 'package:belt/repository/category.repository.dart';
import 'package:mobx/mobx.dart';
part 'category.controller.g.dart';

class CategoryController = CategoryControllerBase with _$CategoryController;

abstract class CategoryControllerBase with Store {
  final CategoryRepository _repository;

  CategoryControllerBase(this._repository);

  @observable
  ObservableList<Category> categorys = ObservableList<Category>.of([Category(name: "Investimentos"),Category(name: "Salário"),Category(name: "Renda Extra")]);


  @observable
  bool isLoading = false;

  @action 
  load() async {
    isLoading = true;
    var response = await _repository.getAll();
    for (var element in response.data!) {
      categorys.add(element);
    }
    isLoading = false;
  }
  
}