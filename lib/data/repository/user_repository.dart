import '../../app/utils/api_utils.dart';
import '../../app/utils/network_utils.dart';
import '../model/user_model.dart';
import '../model/api_model.dart';

class UserRepository {
  final NetworkUtils _networkUtils = NetworkUtils();

  Future<UserModel> getUser(int id) async {
    Map<String, dynamic> result = await _networkUtils.get(ApiUtils.users);

    CApiRes apiModel = CApiRes.fromJson(result);
    if (apiModel.success)
    return  UserModel.fromJson(apiModel.data);
    else
      throw (apiModel.resError);
  }
}
