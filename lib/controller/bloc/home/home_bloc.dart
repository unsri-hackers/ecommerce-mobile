import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:deuvox/data/domain/item_domain.dart';
import 'package:deuvox/data/model/on_going_order_model.dart';
import 'package:deuvox/data/model/product_category_model.dart';
import 'package:deuvox/data/model/your_product_model.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial());

  ItemDomain itemDomain = ItemDomain();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is HomeFetched) {
      yield HomeLoading();
      try {
        final onGoingOrders = <OngoingOrder>[];//await itemDomain.getOnGoingOrders();
        final productCategories = <ProductCategory>[];//await itemDomain.getProductCategories();
        final yourProducts = <YourProduct>[];
        yield HomeSuccess(
          onGoingOrders,
          productCategories,
          yourProducts,
        );
      } catch (e,s) {
        print(e);
        print(s);
        yield HomeFailure();
      }
    }
  }
}
