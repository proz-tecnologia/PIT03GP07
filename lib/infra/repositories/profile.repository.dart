import '/models/api_response.model.dart';
import '/models/profile.model.dart';

abstract class ProfileRepository {
  Future<APIResponse<Profile>> get();
  Future<APIResponse<Profile>> update(Profile newProfile);
}
