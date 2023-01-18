import '/infra/repositories/category.repository.dart';
import '/infra/services/category.service.dart';
import '/models/category.model.dart';
import '/models/api_response.model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryService _service;

  CategoryRepositoryImpl(this._service);

  @override
  Future<APIResponse<Category>> add(Category item) async {
    final docRef = await _service.add(item.toMap());
    item.uid = docRef.id;

    return APIResponse.success(item);
  }

  @override
  Future<APIResponse<List<Category>>> getAllCatecorys() async{
    final querySnapshot = await _service.getAllCatecorys();
    List<Category> listCategorys = [];
    for (var doc in querySnapshot.docs) {
      Category item =
          Category.fromFirestore(doc.data() as Map<String, dynamic>);
      item.uid = doc.id;
      listCategorys.add(item);
    }
    return APIResponse.success(listCategorys);
    
  }

  @override
  Future<APIResponse<bool>> remove(Category item)async {
    final result = await _service.remove(item.uid!);
    if (result) {
      return APIResponse.success(result);
    } else {
      return APIResponse.error("Operação falhou!");
    }
   
  }

  @override
  Future<APIResponse<bool>> update(Category item) {
    throw UnimplementedError();
  }

}