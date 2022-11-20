import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? email;
  final String? password;
  const User({required this.id, this.email, this.password});

  static const empty = User(id: "");

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;
  @override
  List<Object?> get props => throw UnimplementedError();
}
