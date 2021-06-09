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
    BaseResponse response = await _userRepository.login(loginModel);

    // Add Session After Login Success
    if (response.status == Status.SUCCESS) {
      UserModel res = response.result;
      return await addSession(res);
    }
    return false;
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

  Future<bool> addSession(UserModel userModel) {
    return _userDao.createUser(userModel);
  }

  Future<bool> updateSession(UserModel userModel) {
    return _userDao.updateUser(userModel);
  }

  Future<bool> isLoggedIn() async {
    return await _userDao.isLoggedIn();
  }
}
