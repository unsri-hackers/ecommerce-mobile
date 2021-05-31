part of 'upload_item_bloc.dart';

abstract class UploadItemState extends Equatable {
  const UploadItemState();
  @override
  List<Object> get props => [];
}

class UploadItemInitial extends UploadItemState {}

class UploadItemLoading extends UploadItemState {}

class UploadItemSuccess extends UploadItemState {

}

class UploadItemFailure extends UploadItemState {
  final String? error;

  const UploadItemFailure({this.error});

  @override
  List<Object> get props => [error!];
}
