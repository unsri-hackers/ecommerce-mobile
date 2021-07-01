import 'package:deuvox/data/model/user_model.dart';
import 'package:equatable/equatable.dart';

class GetUserProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUserProfileInitState extends GetUserProfileState {}

class GetUserProfileLoadingState extends GetUserProfileState {}

class GetUserProfileSuccessState extends GetUserProfileState {
  final UserModel user;
  GetUserProfileSuccessState({required this.user});

  @override
  List<Object?> get props => [this.user];
}

class GetUserProfileFailedState extends GetUserProfileState {
  final String message;

  GetUserProfileFailedState({required this.message});

  @override
  List<Object?> get props => [this.message];
}
