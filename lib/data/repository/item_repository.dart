import 'package:deuvox/app/utils/api_utils.dart';
import 'package:deuvox/app/utils/network_utils.dart';
import 'package:deuvox/data/model/base_response.dart';
import 'package:deuvox/data/model/on_going_order_model.dart';
import 'package:deuvox/data/model/product_category_model.dart';
import 'package:deuvox/data/model/upload_item_model.dart';
import 'package:deuvox/data/model/your_product_model.dart';

class ItemRepository {
  final NetworkUtils _networkUtils = NetworkUtils();

  Future<BaseResponse<void>> uploadItem(UploadItemModel uploadItemModel) async {
    Map<String, dynamic> result =
        await _networkUtils.post('', body: uploadItemModel.toJson());
    BaseResponse<void> baseResponse =
        BaseResponse.fromJson(result, (json) => null);
    return baseResponse;
  }

  Future<BaseResponse<List<OngoingOrder>>> getOnGoingOrders() async {
    Map<String, dynamic> result = await _networkUtils.get(ApiUtils.onGoingOrders);
    BaseResponse<List<OngoingOrder>> baseResponse = BaseResponse.fromJson(
        result,
        (json) =>
            (json as List).map((e) => OngoingOrder.fromJson(e)).toList());
    return baseResponse;
  }

  Future<BaseResponse<List<ProductCategory>>> getProductCategories() async {
    Map<String, dynamic> result = await _networkUtils.get(ApiUtils.productCategories);
    BaseResponse<List<ProductCategory>> baseResponse = BaseResponse.fromJson(
        result,
        (json) =>
            (json as List).map((e) => ProductCategory.fromJson(e)).toList());
    return baseResponse;
  }

  Future<BaseResponse<List<YourProduct>>> getYourProducts() async {
    Map<String, dynamic> result = await _networkUtils.get(ApiUtils.yourProducts);
    BaseResponse<List<YourProduct>> baseResponse = BaseResponse.fromJson(
        result,
        (json) =>
            (json as List).map((e) => YourProduct.fromJson(e)).toList());
    return baseResponse;
  }
}
