import 'package:deuvox/data/model/base_response.dart';
import 'package:deuvox/data/model/upload_item_model.dart';
import 'package:deuvox/data/repository/item_repository.dart';

class ItemDomain {
  final ItemRepository _itemRepository = ItemRepository();

  Future<BaseResponse<void>> uploadItem(UploadItemModel uploadItemModel) async {
    return await _itemRepository.uploadItem(uploadItemModel);
  }
}
