import 'package:deuvox/data/model/user_model.dart';

import '../dao/user_dao.dart';

class UserDomain {
  // final UserRepository _userRepository = UserRepository();
  final UserDao _userDao = UserDao();

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