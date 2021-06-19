part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<OngoingOrder> onGoingOrders;
  final List<ProductCategory> productCategories;
  final List<YourProduct> yourProducts;

  const HomeSuccess(
      this.onGoingOrders, this.productCategories, this.yourProducts);

  @override
  List<Object> get props => [onGoingOrders, productCategories, yourProducts];
}

class HomeFailure extends HomeState {}
