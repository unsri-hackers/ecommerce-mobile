part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState{}

class HomeSuccess extends HomeState{
  final HomeModel data;
 const HomeSuccess(this.data);
  
  @override
  List<Object> get props => [data];
  
}
class HomeFailure extends HomeState{}