import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  StreamSubscription<User?>? _userSubscription;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState.unknown()) {
    _userSubscription = _authRepository.user.listen(
          (user) => _onUserChanged(user),
    );

    // Stream<AuthState> on<AuthEvent>(
    //     AuthEvent event, Emitter<AuthState> emit) async* {
    //   if (event is AuthUserChanged) {
    //     yield* _mapAuthUserChangedToState(event);
    //   }
    // }
  }

  // Stream<AuthState> _mapAuthUserChangedToState(AuthUserChanged event) async* {
  //   yield AuthState.authenticated(user: event.user);
  // }

  void _onUserChanged(User? user) {
    print('_onUserChanged : Listen on Auth called: ${user}');
    if (user == null) {
      emit(const AuthState.unauthenticated());
    } else {
      emit(AuthState.authenticated(user: user));
    }
  }

  Future<void> signOut() async => await _authRepository.signOut().then((value) => emit(const AuthState.unauthenticated()));

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
