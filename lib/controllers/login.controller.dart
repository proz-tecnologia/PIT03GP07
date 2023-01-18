import '/infra/repositories/auth.repository.dart';
import '/infra/repositories/profile.repository.dart';
import '/models/api_response.model.dart';
import '/stores/user.store.dart';
import 'package:get_it/get_it.dart';

class LoginController {
  final AuthRepository _authRepository;
  final ProfileRepository _profileRepository;

  LoginController(this._authRepository, this._profileRepository);

  final userStore = GetIt.instance.get<UserStore>();

  String _email = "";
  String _password = "";

  changeEmail(String value) {
    _email = value;
  }

  changePassword(String value) {
    _password = value;
  }

  Future<APIResponse<bool>> doLogin() async {
    final userResponse = await _authRepository.doLogin(_email, _password);
    if (userResponse.isSuccess) {
      userStore.setUser(userResponse.data!.uid, userResponse.data!.email!);
      final userProfileResponse = await _profileRepository.get();
      userStore.setUserProfile(userProfileResponse.data!);
      return APIResponse.success(true);
    } else {
      if (_authRepository.checkIfUserLogged()) {
        await _authRepository.logout();
      }
      return APIResponse.error("Falha na autenticação.");
    }
  }
}
