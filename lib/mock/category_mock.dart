import 'package:proz_project_finance/model/category.dart';

abstract class CategoryMock {
  static List<Category> getCategories() {
    return {"Alimentação", "Lazer", "Educação", "Saúde", "Transporte"}
        .map((e) => Category(name: e))
        .toList();
  }
}
