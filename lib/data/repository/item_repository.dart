import 'package:deuvox/app/constant/status.dart';
import 'package:deuvox/app/utils/network_utils.dart';
import 'package:deuvox/data/model/base_response.dart';
import 'package:deuvox/data/model/upload_item_model.dart';

class ItemRepository {
  final NetworkUtils _networkUtils = NetworkUtils();

  Future<BaseResponse<void>> uploadItem(UploadItemModel uploadItemModel) async {
    Map<String, dynamic> result =
        await _networkUtils.post('', body: uploadItemModel.toJson());
    BaseResponse<void> baseResponse =
        BaseResponse.fromJson(result, (json) => null);
    if (baseResponse.status == Status.SUCCESS)
      return baseResponse;
    else
      throw (baseResponse.statusCode);
  }
}
