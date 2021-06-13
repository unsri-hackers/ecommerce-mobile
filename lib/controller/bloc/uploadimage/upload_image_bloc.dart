import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:deuvox/data/model/upload_image_model.dart';
import '../../../app/constant/error_code.dart';
import '../../../data/model/api_model.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'upload_image_event.dart';
part 'upload_image_state.dart';


class UploadImageBloc extends Bloc<UploadImageEvent, UploadImageState> {
  UploadImageBloc() : super(UploadImageInitial());

  //final UploadImageDomain _uploadImageDomain;

  /*
  UploadImageBloc({UploadImageDomain? uploadImageDomain})
      : _uploadImageDomain = uploadImageDomain ?? UploadImageDomain(),
        super(UploadImageInitial());
   */

  @override
  Stream<UploadImageState> mapEventToState(
      UploadImageEvent event,
      ) async* {
    if (event is UploadImageBrowsingFiles) {
      yield* _mapBrowseFilesButtonPressedToState(event);
    }
    if (event is UploadImageStarted) {
      yield* _mapUploadButtonPressedToState(event);
    }
    if (event is UploadImagePreview) {
      yield* _mapUploadGettingPreviewToState(event);
    }
  }

  Stream<UploadImageState> _mapBrowseFilesButtonPressedToState(
      UploadImageBrowsingFiles event) async* {
    try {
      final pickedfile = await ImagePicker().getImage(source: ImageSource.gallery, maxWidth: 150.0, maxHeight: 150.0);
      File image = File(pickedfile!.path);
      yield UploadImagePickerSelected(image);
    } catch (e) {
      yield UploadImagePickerFailure();
    }
  }

  Stream<UploadImageState> _mapUploadButtonPressedToState(
      UploadImageStarted event) async* {
    try {
      yield UploadImageLoading();
      // final resData = await _uploadImageDomain.UploadImageRequest(event.imageUploadImageModel);
      yield UploadImageSuccess(); //get resdata string image_name if successful later
    } catch (e) {
      if (e.runtimeType == CApiResError) {
        final CApiResError resError = e as CApiResError;
        switch (resError.errorCode) {
          case ErrorCode.IMAGE_EXCEEDS_SIZE_LIMIT:
            yield UploadImageExceedsSizeLimit();
            break;
          case ErrorCode.IMAGE_WRONG_RESOLUTION:
            yield UploadImageWrongResolution();
            break;
          default:
            yield UploadImageFailure();
        }
      } else {
        yield UploadImageFailure();
      }
    }
  }

  Stream<UploadImageState> _mapUploadGettingPreviewToState(
      UploadImagePreview event) async* {
    try {
      yield UploadImagePreviewLoading();
      // final resData = await _uploadImageDomain.UploadImagePreviewRequest(event.image_name);
      yield UploadImagePreviewSuccess(File("image_name")); //get resdata image file if successful later
    } catch (e) {
        yield UploadImageFailure();
      }
  }
}