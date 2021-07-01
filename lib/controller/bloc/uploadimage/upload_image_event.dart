part of 'upload_image_bloc.dart';

abstract class UploadImageEvent extends Equatable {
  const UploadImageEvent();

  @override
  List<Object> get props => [];
}

class UploadImageStarted extends UploadImageEvent {
  final List<UploadImageModel> images;

  const UploadImageStarted(this.images);

  @override
  List<Object> get props => [images];
}

class UploadImageBrowsingFiles extends UploadImageEvent {}

class UploadImagePreview extends UploadImageEvent {
  final List<String?> imageurls;

  const UploadImagePreview(this.imageurls);

  @override
  List<Object> get props => [imageurls];
}
