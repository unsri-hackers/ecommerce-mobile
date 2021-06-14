import 'package:deuvox/app/utils/api_utils.dart';
import 'package:deuvox/app/utils/network_utils.dart';
import 'package:deuvox/data/model/base_response.dart';
import 'package:deuvox/data/model/home_model.dart';
import 'package:deuvox/data/model/upload_item_model.dart';

class ItemRepository {
  final NetworkUtils _networkUtils = NetworkUtils();

  Future<BaseResponse<void>> uploadItem(UploadItemModel uploadItemModel) async {
    Map<String, dynamic> result =
        await _networkUtils.post('', body: uploadItemModel.toJson());
    BaseResponse<void> baseResponse =
        BaseResponse.fromJson(result, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse<HomeModel>> getHomeData() async {
    Map<String, dynamic> result = await _networkUtils.get(ApiUtils.homeData);
    BaseResponse<HomeModel> baseResponse = BaseResponse.fromJson(
        result, (json) => HomeModel.fromJson(json as Map<String, dynamic>));
    return baseResponse;
  }
}
