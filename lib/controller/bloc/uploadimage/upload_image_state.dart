part of 'upload_image_bloc.dart';

abstract class UploadImageState extends Equatable {
  const UploadImageState();
  @override
  List<Object> get props => [];
}

class UploadImageInitial extends UploadImageState {}

class UploadImageLoading extends UploadImageState {}

class UploadImageSuccess extends UploadImageState {
  final List<String?> imageurls;

  const UploadImageSuccess(this.imageurls);

  @override
  List<Object> get props => [imageurls];
}

class UploadImageFailure extends UploadImageState {
  final String? error;

  const UploadImageFailure({this.error});

  @override
  List<Object> get props => [error!];
}

class UploadImagePickerFailure extends UploadImageState {
  final String? error;

  const UploadImagePickerFailure({this.error});

  @override
  List<Object> get props => [error!];
}

class UploadImageCloudinaryFailure extends UploadImageState {
  final String? error;

  const UploadImageCloudinaryFailure({this.error});

  @override
  List<Object> get props => [error!];
}

class UploadImagePickerSelected extends UploadImageState {
  final List<PickedFile>? pickedImageList;

  const UploadImagePickerSelected(this.pickedImageList);

  @override
  List<Object> get props => [pickedImageList!];
}

class UploadImageCloudinaryLoading extends UploadImageState {}

class UploadImagePreviewLoading extends UploadImageState {}

class UploadImagePreviewSuccess extends UploadImageState {
  final List<String?> imageurls;

  const UploadImagePreviewSuccess(this.imageurls);

  @override
  List<Object> get props => [imageurls];
}

class UploadImageExceedsSizeLimit extends UploadImageState {}

class UploadImageWrongResolution extends UploadImageState {}

