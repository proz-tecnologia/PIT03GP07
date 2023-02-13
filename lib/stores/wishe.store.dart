import 'package:mobx/mobx.dart';

import '../models/wishe.model.dart';


part 'wishe.store.g.dart';

class WisheStore = WisheStoreBase with _$WisheStore;

abstract class WisheStoreBase with Store {
  final ObservableList<Wishes> list = ObservableList();

  double totalWishes() {
    double total = 0;
    for (var element in list) {
      total += element.value;
    }
    return total;
  }

  @action
  replaceList(List<Wishes> wishes) {
    list.clear();
    list.addAll(wishes);
    list.sort((a,b) => a.dateExpectedt!.compareTo(b.dateExpectedt!));
  }

  @action
  addWishe(Wishes wishe) {
    list.add(wishe);
  }

  @action
  removeWishes(Wishes wishes) {
    list.removeWhere((e) => e.uid == wishes.uid);
  }
}