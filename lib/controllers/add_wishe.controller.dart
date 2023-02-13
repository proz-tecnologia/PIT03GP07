import 'package:money/models/wishe.model.dart';

import '../infra/repositories/wishe.repository.dart';
import '../models/api_response.model.dart';
import '../stores/wishe.store.dart';
import 'package:get_it/get_it.dart';

class AddWisheController {
  final WisheRepository _repository;

  AddWisheController(this._repository);

  final _store = GetIt.instance.get<WisheStore>();

  Future<bool> registerWishe(
      double value, String description, DateTime dateExpected, DateTime dateInital) async {
    Wishes wishe =
        Wishes(dateExpectedt: dateExpected, description: description,value: value,dateInitial: dateInital);
    final response = await _repository.add(wishe);
    if (response.isSuccess) {
      _store.addWishe(response.data!);
      return true;
    } else {
      return false;
    }
  }

   Future<APIResponse<List<Wishes>>> getList() async {
    final response = await _repository.getAllWishes();
    if (response.isSuccess) {
      final store = GetIt.instance.get<WisheStore>();
      store.replaceList(response.data!);
    }
    return response;
  }
}
