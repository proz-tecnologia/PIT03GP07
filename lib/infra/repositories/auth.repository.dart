import '/models/api_response.model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<APIResponse<String?>> createUser(
      String fullName, String email, String password);
  bool checkIfUserLogged();
  User getUser();
  Future<APIResponse<User?>> doLogin(String email, String password);
  Future<APIResponse<bool>> logout();
}
