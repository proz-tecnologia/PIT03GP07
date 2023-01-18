import '/infra/repositories/auth.repository.dart';
import '/infra/repositories/profile.repository.dart';
import '/models/api_response.model.dart';
import '/models/profile.model.dart';
import '/stores/user.store.dart';
import 'package:get_it/get_it.dart';

class RegisterController {
  final AuthRepository _authRepository;
  final ProfileRepository _profileRepository;

  RegisterController(this._authRepository, this._profileRepository);

  final userStore = GetIt.instance.get<UserStore>();

  String _name = "";
  String _email = "";
  String _password = "";
  String _repeatPassword = "";

  changeName(String value) {
    _name = value;
  }

  changeEmail(String value) {
    _email = value;
  }

  changePassword(String value) {
    _password = value;
  }

  changeRepeatPassword(String value) {
    _repeatPassword = value;
  }

  Future<APIResponse<bool>> doRegister() async {
    if (_name.isEmpty) {
      return APIResponse.error("Nome não pode ser vazio.");
    }

    if (_name.split(' ').length == 1) {
      return APIResponse.error("É necessário ao menos um sobrenome.");
    }

    if (_password != _repeatPassword) {
      return APIResponse.error("Senhas precisam ser iguais.");
    }

    final result = await _authRepository.createUser(_name, _email, _password);
    if (result.data != null) {
      userStore.setUser(result.data!, _email);
      final profile = Profile(fullName: _name);
      userStore.setUserProfile(profile);
      return APIResponse.success(true);
    } else {
      return APIResponse.error("Ops! Algum problema aconteceu!");
    }
  }
}
