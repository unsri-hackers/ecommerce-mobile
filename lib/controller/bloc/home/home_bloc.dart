import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:deuvox/data/domain/item_domain.dart';
import 'package:deuvox/data/model/home_model.dart';
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
        final data = await itemDomain.getHomeData();
        yield HomeSuccess(data.result);
      } catch (e) {
        yield HomeFailure();
      }
    }
  }
}
