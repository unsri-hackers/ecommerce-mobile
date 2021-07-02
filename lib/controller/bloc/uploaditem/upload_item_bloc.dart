import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:deuvox/data/model/upload_item_model.dart';
import '../../../data/domain/item_domain.dart';
import 'package:equatable/equatable.dart';

part 'upload_item_event.dart';
part 'upload_item_state.dart';

class UploadItemBloc extends Bloc<UploadItemEvent, UploadItemState> {
  final ItemDomain _itemDomain;

  UploadItemBloc({ItemDomain? itemDomain})
      : _itemDomain = itemDomain ?? ItemDomain(),
        super(UploadItemInitial());

  @override
  Stream<UploadItemState> mapEventToState(
      UploadItemEvent event,
      ) async* {
    if (event is UploadItemStarted) {
      yield* _mapUploadButtonPressedToState(event);
    }
  }

  Stream<UploadItemState> _mapUploadButtonPressedToState(
      UploadItemStarted event) async* {
    try {
      yield UploadItemLoading();
      final resData = await _itemDomain.uploadItem(event.form);
      if (resData.statusCode == "200") {
        yield UploadItemSuccess();
      }  else {
        yield UploadItemFailure();
        print(resData.statusCode);
      }
      yield UploadItemSuccess();
    } catch (e) {
      yield UploadItemFailure();
    }
  }
}