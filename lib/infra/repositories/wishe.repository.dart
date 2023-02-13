import 'package:money/models/wishe.model.dart';

import '/models/api_response.model.dart';

abstract class WisheRepository {
  Future<APIResponse<List<Wishes>>> getAllWishes();
  Future<APIResponse<Wishes>> add(Wishes item);
  Future<APIResponse<bool>> update(Wishes item);
  Future<APIResponse<bool>> remove(Wishes item);
}
