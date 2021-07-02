import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import '../../../app/constant/error_code.dart';
import '../../../data/model/api_model.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'upload_image_event.dart';
part 'upload_image_state.dart';


class UploadImageBloc extends Bloc<UploadImageEvent, UploadImageState> {
  UploadImageBloc() : super(UploadImageInitial());
  final cloudinary = CloudinaryPublic('deuvox', 'deuvox-products-unsigned', cache: false);

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
      final pickedImageList = await ImagePicker().getMultiImage();
      yield UploadImagePickerSelected(pickedImageList);
    } catch (e) {
      print(e.toString());
      yield UploadImagePickerFailure();
    }
  }

  Stream<UploadImageState> _mapUploadButtonPressedToState(
      UploadImageStarted event) async* {
    try {
      yield UploadImageLoading();
      print(event.images.length);
      print(event.images[0].path);
      List<String?> imageurls = [];
      try {
        for(int i = 0; i < event.images.length; i++) {
          CloudinaryResponse response = await cloudinary.uploadFile(
              CloudinaryFile.fromFile(event.images[i].path, resourceType: CloudinaryResourceType.Image)
          );
          imageurls.add(response.secureUrl);
        }
      } on CloudinaryException catch (e) {
        yield UploadImageCloudinaryFailure();
      }
      yield UploadImageSuccess(imageurls);
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
      yield UploadImagePreviewSuccess(event.imageurls);
    } catch (e) {
        yield UploadImageFailure();
      }
  }
}