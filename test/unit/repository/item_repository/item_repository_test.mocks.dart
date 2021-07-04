// Mocks generated by Mockito 5.0.10 from annotations
// in deuvox/test/unit/repository/item_repository/item_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:deuvox/data/model/base_response.dart' as _i2;
import 'package:deuvox/data/model/on_going_order_model.dart' as _i6;
import 'package:deuvox/data/model/product_category_model.dart' as _i7;
import 'package:deuvox/data/model/upload_item_model.dart' as _i3;
import 'package:deuvox/data/model/your_product_model.dart' as _i8;
import 'package:deuvox/data/repository/item_repository.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeBaseResponse<T> extends _i1.Fake implements _i2.BaseResponse<T> {}

/// A class which mocks [UploadItemModel].
///
/// See the documentation for Mockito's code generation for more information.
class MockUploadItemModel extends _i1.Mock implements _i3.UploadItemModel {
  MockUploadItemModel() {
    _i1.throwOnMissingStub(this);
  }

  @override
  set name(String? _name) => super.noSuchMethod(Invocation.setter(#name, _name),
      returnValueForMissingStub: null);
  @override
  set price(String? _price) =>
      super.noSuchMethod(Invocation.setter(#price, _price),
          returnValueForMissingStub: null);
  @override
  set photos(List<dynamic>? _photos) =>
      super.noSuchMethod(Invocation.setter(#photos, _photos),
          returnValueForMissingStub: null);
  @override
  Map<String, dynamic> toJson() =>
      (super.noSuchMethod(Invocation.method(#toJson, []),
          returnValue: <String, dynamic>{}) as Map<String, dynamic>);
}

/// A class which mocks [ItemRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockItemRepository extends _i1.Mock implements _i4.ItemRepository {
  MockItemRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.BaseResponse<void>> uploadItem(
          _i3.UploadItemModel? uploadItemModel) =>
      (super.noSuchMethod(Invocation.method(#uploadItem, [uploadItemModel]),
              returnValue: Future<_i2.BaseResponse<void>>.value(
                  _FakeBaseResponse<void>()))
          as _i5.Future<_i2.BaseResponse<void>>);
  @override
  _i5.Future<_i2.BaseResponse<List<_i6.OngoingOrder>>> getOnGoingOrders() =>
      (super.noSuchMethod(Invocation.method(#getOnGoingOrders, []),
          returnValue: Future<_i2.BaseResponse<List<_i6.OngoingOrder>>>.value(
              _FakeBaseResponse<List<_i6.OngoingOrder>>())) as _i5
          .Future<_i2.BaseResponse<List<_i6.OngoingOrder>>>);
  @override
  _i5.Future<_i2.BaseResponse<List<_i7.ProductCategory>>>
      getProductCategories() =>
          (super.noSuchMethod(Invocation.method(#getProductCategories, []),
                  returnValue:
                      Future<_i2.BaseResponse<List<_i7.ProductCategory>>>.value(
                          _FakeBaseResponse<List<_i7.ProductCategory>>()))
              as _i5.Future<_i2.BaseResponse<List<_i7.ProductCategory>>>);
  @override
  _i5.Future<_i2.BaseResponse<List<_i8.YourProduct>>> getYourProducts() =>
      (super.noSuchMethod(Invocation.method(#getYourProducts, []),
          returnValue: Future<_i2.BaseResponse<List<_i8.YourProduct>>>.value(
              _FakeBaseResponse<List<_i8.YourProduct>>())) as _i5
          .Future<_i2.BaseResponse<List<_i8.YourProduct>>>);
}
