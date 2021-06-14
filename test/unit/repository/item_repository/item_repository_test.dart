import 'package:deuvox/data/model/base_response.dart';
import 'package:deuvox/data/model/upload_item_model.dart';
import 'package:deuvox/data/repository/item_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

import '../item_repository/item_repository_test.mocks.dart';

@GenerateMocks([UploadItemModel, ItemRepository])
void main() {
  test('Test Upload Item (Success Scenario)', () async {
    final itemRepository = MockItemRepository();
    final uploadItemModel = MockUploadItemModel();
    Future<BaseResponse<void>> expected = successResponse();

    when(itemRepository.uploadItem(uploadItemModel))
        .thenAnswer((_) async => expected);

    var res = await itemRepository.uploadItem(uploadItemModel);
    expect(res.statusCode, "200");
  });
}

Future<BaseResponse<void>> successResponse() async {
  return BaseResponse<void>(statusCode: "200", result: null,message: "null");
}
