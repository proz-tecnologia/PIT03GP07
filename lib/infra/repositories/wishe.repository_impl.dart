import 'package:money/infra/repositories/wishe.repository.dart';
import 'package:money/models/wishe.model.dart';
import 'package:money/models/api_response.model.dart';

import '../services/wishe.service.dart';

class WisheRepositoryImpl implements WisheRepository {

  final WisheService _service;

  WisheRepositoryImpl(this._service);

  @override
  Future<APIResponse<List<Wishes>>> getAllWishes() async {
    final querySnapshot = await _service.getAllWhishes();
    List<Wishes> listWishes = [];
    for (var doc in querySnapshot.docs) {
      Wishes item =
          Wishes.fromFirestore(doc.data() as Map<String, dynamic>);
      item.uid = doc.id;
      listWishes.add(item);
    }
    return APIResponse.success(listWishes);
  }

  @override
  Future<APIResponse<Wishes>> add(Wishes item) async {
    final docRef = await _service.add(item.toMap());
    item.uid = docRef.id;

    return APIResponse.success(item);
  }

  @override
  Future<APIResponse<bool>> remove(Wishes item) async {
    final result = await _service.remove(item.uid!);
    if (result) {
      return APIResponse.success(result);
    } else {
      return APIResponse.error("Operação falhou!");
    }
  }

  @override
  Future<APIResponse<bool>> update(Wishes item) {
    throw UnimplementedError();
  }
  

}