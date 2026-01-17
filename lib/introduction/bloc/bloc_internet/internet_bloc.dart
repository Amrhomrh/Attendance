
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'internet_event.dart';
import 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent,InternetStates>{

  Connectivity _connectivity = Connectivity();
  StreamSubscription ? connectivitySubscription; // to stop the listener


  InternetBloc(): super(InternetInitialState()){
    on<InternetLostEvent>((event, emit) => emit(InternetLostState()));
    on<InternetGainedEvent>((event, emit) => emit(InternetGainedState()));
    _emitInitialConnectivityState();

    connectivitySubscription= _connectivity.onConnectivityChanged.listen((result) {

      if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi)
      {
        add(InternetGainedEvent());
      }
      else
      {
        add(InternetLostEvent());
      }
    });


  }

  Future<void> _emitInitialConnectivityState() async {
    final result = await _connectivity.checkConnectivity();

    if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
      add(InternetGainedEvent());
    } else {
      add(InternetLostEvent());
    }
  }

// this is predefined but i am adding slight alteration
  @override
  Future<void> close() {

    connectivitySubscription?.cancel();
    return super.close();
  }
}
