import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState()) {
    on<AppSignIn>(_onAppSignIn);
    on<AppSignUp>(_onAppSignUp);
    on<AppLogout>(_onAppLogout);
  }
  final _auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController rePassword = TextEditingController();
  _onAppSignIn(AppSignIn event, Emitter<AppState> emit) {
    try {
      _auth.signInWithEmailAndPassword(
          email: event.email, password: event.password);
    } catch (e) {
      print("Tài khoản hoặc mật khẩu không chính xác");
    }
  }

  _onAppSignUp(AppSignUp event, Emitter<AppState> emit) {
    _auth.createUserWithEmailAndPassword(
        email: event.email, password: event.password);
  }

  _onAppLogout(AppLogout event, Emitter<AppState> emit) {
    unawaited(_auth.signOut());
  }
}
