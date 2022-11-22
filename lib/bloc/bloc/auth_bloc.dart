import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {
    on<SignInRequested>(_onSignInRequested);

    on<SignUpRequested>(_onSignUpRequested);

    on<SignOutRequested>(_onSignOutRequested);
  }

  _onSignInRequested(SignInRequested event, Emitter<AuthState> emit) {
    emit(Loading());
    try {
      authRepository.signIn(email: event.email, password: event.password);
      emit(Authenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(UnAuthenticated());
    }
  }

  FutureOr<void> _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) {
    emit(Loading());
    try {
      authRepository.signUp(email: event.email, password: event.password);
      emit(Authenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(UnAuthenticated());
    }
  }

  _onSignOutRequested(SignOutRequested event, Emitter<AuthState> emit) {
    emit(Loading());
    authRepository.signOut();
    emit(UnAuthenticated());
  }
}
