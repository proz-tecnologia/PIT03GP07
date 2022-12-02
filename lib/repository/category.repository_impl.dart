import 'package:belt/model/api_response.model.dart';
import 'package:belt/model/category.model.dart';
import 'package:belt/repository/category.repository.dart';
import 'package:belt/service/api.service.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final APIService _apiService;

 CategoryRepositoryImpl(this._apiService);

  @override
  Future<APIResponse<Category>> add(Category item) async {
    try {
      final response = await _apiService.addCategory(item);
      if (response.statusCode == 201) {
        final dataObject = Map<String, dynamic>.from(response.data);
        final item = Category.fromJson(dataObject);
        return APIResponse.success(item);
      } else {
        return APIResponse.error("Ops! Ocorreu uma falha na operação, tente novamente em breve!");
      }
    } on Exception catch (e) {
      return APIResponse.error(e.toString());
    }
  }

  @override
  Future<APIResponse> delete(Category item) async {
    try {
      final response = await _apiService.deleteCategory(item);
      if (response.statusCode == 200) {
        return APIResponse.success(null);
      } else {
        return APIResponse.error("Ops! Item não encontrado!");
      }
    } on Exception catch (e) {
      return APIResponse.error(e.toString());
    }
  }

  @override
  Future<APIResponse<List<Category>>> getAll() async {
    try {
      final response = await _apiService.getAllCategory();
      if (response.statusCode == 200) {
        final dataObject = List<Map<String, dynamic>>.from(response.data);
        List<Category> items = [];
        for (var element in dataObject) {
          items.add(Category.fromJson(element));
        }
        return APIResponse.success(items);
      } else {
        return APIResponse.error("Ops! Ocorreu uma falha na operação, tente novamente em breve!");
      }
    } on Exception catch (e) {
      return APIResponse.error(e.toString());
    }
  }

  @override
  Future<APIResponse<Category>> getById(String id) async {
    try {
      final response = await _apiService.getByIdCategory(id);
      if (response.statusCode == 200) {
        final dataObject = Map<String, dynamic>.from(response.data);
        final item = Category.fromJson(dataObject);
        return APIResponse.success(item);
      } else {
        return APIResponse.error("Ops! Item não encontrado!");
      }
    } on Exception catch (e) {
      return APIResponse.error(e.toString());
    }
  }

  @override
  Future<APIResponse> update(Category item) async {
    try {
      final response = await _apiService.updateCategory(item);
      if (response.statusCode == 200) {
        return APIResponse.success(null);
      } else {
        return APIResponse.error("Ops! Ocorreu uma falha na operação, tente novamente em breve!");
      }
    } on Exception catch (e) {
      return APIResponse.error(e.toString());
    }
  }
}