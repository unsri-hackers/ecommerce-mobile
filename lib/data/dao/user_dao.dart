import '../../app/utils/hive_utils.dart';
import '../model/user_model.dart';
import 'package:hive/hive.dart';

class UserDao {
  final HiveUtils dbProvider;
  UserDao() : dbProvider = HiveUtils(HiveBox.user);

  String _userKey = "user";

  Future<bool> createUser(UserSessionModel user) async {
    final Box db = await dbProvider.dataBox;
    await db.put(_userKey, user.toJson());
    return true;
  }

  Future<bool> updateUser(UserSessionModel user) async {
    final Box db = await dbProvider.dataBox;
    await db.put(_userKey, user.toJson());
    return true;
  }

  Future<void> deleteUser() async {
    final Box db = await dbProvider.dataBox;
    await db.delete(_userKey);
  }

  Future<bool> isLoggedIn() async {
    final Box db = await dbProvider.dataBox;
    if (db.isNotEmpty) {
      return db.get(_userKey) != null;
    } else {
      return false;
    }
  }

  Future<UserSessionModel> getUser() async {
    final db = await dbProvider.dataBox;
    final maps = db.get(_userKey);
    Map<String, dynamic> castData = Map<String, dynamic>.from(maps);
    return UserSessionModel.fromJson(castData);
  }
}
