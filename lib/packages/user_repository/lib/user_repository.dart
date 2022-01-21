import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/user/user_entity.dart';
import 'package:akademi_al_mobile_app/packages/user_repository/lib/src/user_api_provider.dart';

class UserRepository {
  static UserRepository _instance;

  UserRepository._privateConstructor(
      AuthenticationRepository authenticationRepository)
      : _apiProvider = new UserApiProvider(authenticationRepository) {
    _instance = this;
  }

  factory UserRepository({AuthenticationRepository authenticationRepository}) =>
      _instance ?? UserRepository._privateConstructor(authenticationRepository);

  final UserApiProvider _apiProvider;

  Future<UserEntity> getUserEntity() async {
    final userEntity = await _apiProvider.getCurrentUserEntity();
    return userEntity;
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    await _apiProvider.changePassword(oldPassword, newPassword);
  }

  Future<void> updateProfile(String name, String lastName, String userName, String nationality) async{
    await _apiProvider.updateProfile(name, lastName, userName, nationality);
  }
}
