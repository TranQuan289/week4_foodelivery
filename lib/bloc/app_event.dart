part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppSignIn extends AppEvent {
  final String email;
  final String password;

  const AppSignIn({required this.email, required this.password});
}

class AppSignUp extends AppEvent {
  final String email;
  final String password;

  const AppSignUp({required this.email, required this.password});
}

class AppLogout extends AppEvent {}

class SignInSuccess extends AppEvent {}

class SignInFail extends AppEvent {}
