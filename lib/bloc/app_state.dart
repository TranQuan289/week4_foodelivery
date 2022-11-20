part of 'app_bloc.dart';

class AppState extends Equatable {
  @override
  List<Object> get props => [];
}

class App extends AppState {
  final User user;
  App(this.user);
}
