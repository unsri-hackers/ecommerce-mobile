import 'package:deuvox/data/model/base_response.dart';
import 'package:deuvox/data/model/login_model.dart';
import '../../app/utils/api_utils.dart';
import '../../app/utils/network_utils.dart';
import '../model/user_model.dart';
import '../model/api_model.dart';

class UserRepository {
  final NetworkUtils _networkUtils = NetworkUtils();

  Future<BaseResponse<UserSessionModel>> login(LoginModel loginModel) async {
    Map<String, dynamic> result =
        await _networkUtils.post(ApiUtils.login, body: loginModel.toJson());

    BaseResponse<UserSessionModel> response = BaseResponse<UserSessionModel>.fromJson(
        result, (e) => UserSessionModel.fromJson(e as Map<String, dynamic>));

    return response;
  }

  Future<UserModel> getUserProfile(int id) async {
    Map<String, dynamic> result = await _networkUtils.get(ApiUtils.userProfile);

    CApiRes apiModel = CApiRes.fromJson(result);
    if (apiModel.success)
      return UserModel.fromJson(apiModel.data);
    else
      throw (apiModel.resError);
  }
}
