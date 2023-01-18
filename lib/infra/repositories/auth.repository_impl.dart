import '/infra/repositories/auth.repository.dart';
import '/infra/services/auth.service.dart';
import '/models/api_response.model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _service;

  AuthRepositoryImpl(this._service);

  @override
  Future<APIResponse<String?>> createUser(
      String fullName, String email, String password) async {
    final response = await _service.createUser(fullName, email, password);
    return APIResponse.success(response);
  }

  @override
  bool checkIfUserLogged() {
    return FirebaseAuth.instance.currentUser != null;
  }

  @override
  Future<APIResponse<User?>> doLogin(String email, String password) async {
    final response = await _service.doLogin(email, password);
    return APIResponse.success(response);
  }

  @override
  Future<APIResponse<bool>> logout() async {
    final result = await _service.logout();
    return APIResponse.success(result);
  }

  @override
  User getUser() {
    final user = _service.getUser();
    if (user != null) {
      return user;
    } else {
      throw Exception("Usuário não logado!");
    }
  }
}
