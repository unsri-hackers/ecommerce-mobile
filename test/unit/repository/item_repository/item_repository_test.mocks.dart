// Mocks generated by Mockito 5.0.9 from annotations
// in deuvox/test/unit/repository/item_repository/item_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:deuvox/data/model/base_response.dart' as _i2;
import 'package:deuvox/data/model/upload_item_model.dart' as _i3;
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
  String get id =>
      (super.noSuchMethod(Invocation.getter(#id), returnValue: '') as String);
  @override
  set id(String? _id) => super.noSuchMethod(Invocation.setter(#id, _id),
      returnValueForMissingStub: null);
  @override
  String get name =>
      (super.noSuchMethod(Invocation.getter(#name), returnValue: '') as String);
  @override
  set name(String? _name) => super.noSuchMethod(Invocation.setter(#name, _name),
      returnValueForMissingStub: null);
  @override
  double get price =>
      (super.noSuchMethod(Invocation.getter(#price), returnValue: 0) as double);
  @override
  set price(double? _price) =>
      super.noSuchMethod(Invocation.setter(#price, _price),
          returnValueForMissingStub: null);
  @override
  String get condition =>
      (super.noSuchMethod(Invocation.getter(#condition), returnValue: '')
          as String);
  @override
  set condition(String? _condition) =>
      super.noSuchMethod(Invocation.setter(#condition, _condition),
          returnValueForMissingStub: null);
  @override
  double get weight =>
      (super.noSuchMethod(Invocation.getter(#weight), returnValue: 0.0)
          as double);
  @override
  set weight(double? _weight) =>
      super.noSuchMethod(Invocation.setter(#weight, _weight),
          returnValueForMissingStub: null);
  @override
  String get filename =>
      (super.noSuchMethod(Invocation.getter(#filename), returnValue: '')
          as String);
  @override
  set filename(String? _filename) =>
      super.noSuchMethod(Invocation.setter(#filename, _filename),
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
}
