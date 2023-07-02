import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justaudioplayer/bloc/homepage/home_envent.dart';

import 'home_state.dart';

class Homebloc extends Bloc<IHomeEvent, IHomeState> {
  late int index;

  Homebloc(super.initialState) {
    on<HomeEvent>((event, emit) {
      index = event.index;
      emit(HomeState(index));
    });
  }
}
