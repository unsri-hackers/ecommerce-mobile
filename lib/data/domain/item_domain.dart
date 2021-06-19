import 'package:deuvox/data/model/base_response.dart';
import 'package:deuvox/data/model/on_going_order_model.dart';
import 'package:deuvox/data/model/product_category_model.dart';
import 'package:deuvox/data/model/upload_item_model.dart';
import 'package:deuvox/data/model/your_product_model.dart';
import 'package:deuvox/data/repository/item_repository.dart';

class ItemDomain {
  final ItemRepository _itemRepository = ItemRepository();

  Future<BaseResponse<void>> uploadItem(UploadItemModel uploadItemModel) {
    return _itemRepository.uploadItem(uploadItemModel);
  }

  Future<BaseResponse<List<OngoingOrder>>> getOnGoingOrders() {
    return _itemRepository.getOnGoingOrders();
  }

  Future<BaseResponse<List<ProductCategory>>> getProductCategories() {
    return _itemRepository.getProductCategories();
  }

  Future<BaseResponse<List<YourProduct>>> getYourProducts() {
    return _itemRepository.getYourProducts();
  }
}
