part of 'upload_item_bloc.dart';

abstract class UploadItemEvent extends Equatable {
  const UploadItemEvent();

  @override
  List<Object> get props => [];
}

class UploadItemStarted extends UploadItemEvent {
  final UploadItemModel form;

  const UploadItemStarted(this.form);

  @override
  List<Object> get props => [form];
}