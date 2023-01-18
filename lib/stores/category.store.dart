import 'package:mobx/mobx.dart';

import '../models/category.model.dart';

part 'category.store.g.dart';

class CategoryStore = CategoryStoreBase with _$CategoryStore;

abstract class CategoryStoreBase with Store {
  final ObservableList<Category> list = ObservableList();

  List<Category> defultCategorys = [Category(name: "Salário", typeTransaction: "INCOME"),
    Category(name: "Investimento", typeTransaction: "INCOME"),
    Category(name: "Renda Extra", typeTransaction: "INCOME"),
    Category(name: "Alimentação", typeTransaction: "EXPENSE"),
    Category(name: "Lazer", typeTransaction: "EXPENSE"),
    Category(name: "Pagamentos", typeTransaction: "EXPENSE")
  ];

  @computed
  int get count => list.length;

  @action
  replaceList(List<Category> Category) {
    list.clear();
    list.addAll(defultCategorys);
    list.addAll(Category);
  }

  @action
  addTransaction(Category transaction) {
    list.add(transaction);
  }

  @action
  removeCategory(Category category) {
    list.removeWhere((e) => e.uid == category.uid);
  }

 
}
