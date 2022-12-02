import 'package:belt/model/api_response.model.dart';
import 'package:belt/model/category.model.dart';

abstract class CategoryRepository {
  Future<APIResponse<List<Category>>> getAll();
  Future<APIResponse<Category>> add(Category item);
  Future<APIResponse<Category>> getById(String id);
  Future<APIResponse> update(Category item);
  Future<APIResponse> delete(Category item);
}