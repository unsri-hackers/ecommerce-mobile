import 'package:deuvox/app/constant/status.dart';
import 'package:deuvox/data/model/base_response.dart';
import 'package:deuvox/data/model/login_model.dart';
import 'package:deuvox/data/model/user_model.dart';
import 'package:deuvox/data/repository/user_repository.dart';
import '../dao/user_dao.dart';

class UserDomain {
  final UserRepository _userRepository = UserRepository();
  final UserDao _userDao = UserDao();

  Future<bool> login(LoginModel loginModel) async {
    BaseResponse<UserSessionModel> response =
        await _userRepository.login(loginModel);
    print(response.result.username);
    // Add Session After Login Success
    UserSessionModel res = response.result;
    return await addSession(res);
  }

  Future<UserModel> getCurrentSession() async {
    return await _userDao.getUser();
  }

  Future<void> logout() async {
    final user = await _userDao.getUser();
    //Remove FCM token from this devices
    // await FirebaseMessaging.instance.deleteToken();
    await _userDao.deleteUser();
  }

  Future<bool> addSession(UserSessionModel userModel) {
    return _userDao.createUser(userModel);
  }

  Future<bool> updateSession(UserSessionModel userModel) {
    return _userDao.updateUser(userModel);
  }

  Future<bool> isLoggedIn() async {
    return await _userDao.isLoggedIn();
  }
}
