import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'internet_state.dart';

class InternetBloc extends Cubit<InternetState> {
  final Connectivity _connectivity = Connectivity();

  StreamSubscription? _stream;
  InternetBloc() : super(InternetInitialState()) {
    _stream = _connectivity.onConnectivityChanged.listen((event) {
      if (ConnectivityResult.wifi == event ||
          ConnectivityResult.mobile == event) {
        emit(InternetGainedState());
      } else {
        emit(InternetLossState());
      }
    });
  }

  @override
  Future<void> close() {
    _stream?.cancel();
    return super.close();
  }
}
