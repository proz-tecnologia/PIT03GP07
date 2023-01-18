import '/models/api_response.model.dart';
import '/models/category.model.dart';

abstract class CategoryRepository {
  Future<APIResponse<List<Category>>> getAllCatecorys();
  Future<APIResponse<Category>> add(Category item);
  Future<APIResponse<bool>> update(Category item);
  Future<APIResponse<bool>> remove(Category item);
}
