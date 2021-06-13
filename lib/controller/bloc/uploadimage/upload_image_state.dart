part of 'upload_image_bloc.dart';

abstract class UploadImageState extends Equatable {
  const UploadImageState();
  @override
  List<Object> get props => [];
}

class UploadImageInitial extends UploadImageState {}

class UploadImageLoading extends UploadImageState {}

class UploadImageSuccess extends UploadImageState {}

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

class UploadImagePickerSelected extends UploadImageState {
  final File image;

  const UploadImagePickerSelected(this.image);

  @override
  List<Object> get props => [image];
}

class UploadImagePreviewLoading extends UploadImageState {}

class UploadImagePreviewSuccess extends UploadImageState {
  final File image;

  const UploadImagePreviewSuccess(this.image);

  @override
  List<Object> get props => [image];
}

class UploadImageExceedsSizeLimit extends UploadImageState {}

class UploadImageWrongResolution extends UploadImageState {}

