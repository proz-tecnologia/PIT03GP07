import '/models/profile.model.dart';
import 'package:mobx/mobx.dart';

part 'user.store.g.dart';

class UserStore = UserStoreBase with _$UserStore;

abstract class UserStoreBase with Store {
  @readonly
  String? _uid;

  @readonly
  String? _email;

  @readonly
  Profile? _profile;

  @action
  setUser(String uid, String email) {
    _uid = uid;
    _email = _email;
  }

  @action
  setUserProfile(Profile profile) {
    _profile = profile;
  }

  @action
  unloadUser() {
    _uid = null;
    _email = null;
    _profile = null;
  }
}
