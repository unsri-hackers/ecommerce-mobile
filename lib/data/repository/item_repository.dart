import 'package:deuvox/app/utils/network_utils.dart';
import 'package:deuvox/data/model/base_response.dart';

class ItemRepository {
  final NetworkUtils _networkUtils = NetworkUtils();

  Future<BaseResponse<void>> uploadItem() async {
    Map<String, dynamic> result = await _networkUtils.post('');
    BaseResponse<void> baseResponse =
        BaseResponse.fromJson(result, (json) => null);
    if (baseResponse.status == 'Success')
      return baseResponse;
    else
      throw (baseResponse.status);
  }
}
