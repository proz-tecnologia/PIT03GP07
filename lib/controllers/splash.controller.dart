import '/infra/repositories/auth.repository.dart';
import '/infra/repositories/profile.repository.dart';
import '/models/api_response.model.dart';
import '/stores/user.store.dart';
import 'package:get_it/get_it.dart';

class SplashController {
  final AuthRepository _authRepository;
  final ProfileRepository _profileRepository;

  SplashController(this._authRepository, this._profileRepository);

  bool checkIfUserLogged() {
    return _authRepository.checkIfUserLogged();
  }

  Future<APIResponse<bool>> login() async {
    final userStore = GetIt.instance.get<UserStore>();
    try {
      final user = _authRepository.getUser();
      userStore.setUser(user.uid, user.email!);

      final userProfileResponse = await _profileRepository.get();
      userStore.setUserProfile(userProfileResponse.data!);

      return APIResponse.success(true);
    } on Exception catch (e) {
      return APIResponse.error(e.toString());
    }
  }
}
