// ignore_for_file: deprecated_member_use

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week4_food_delivery/bloc/app_bloc.dart';
import 'package:week4_food_delivery/firebase_options.dart';
import 'package:week4_food_delivery/page/sign_in_up.dart';
import 'package:week4_food_delivery/repositories/auth_repositories.dart';

Future<void> main() {
  return BlocOverrides.runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final authRepository = AuthRepository();
    runApp(MyApp(authRepository: authRepository));
  });
}

class MyApp extends StatelessWidget {
  final AuthRepository _authRepository;
  const MyApp({Key? key, required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: _authRepository,
        child: BlocProvider(
          create: (_) => AppBloc(authRepository: _authRepository),
          child: const MaterialApp(
            color: Colors.white,
            home: SignInUp(),
          ),
        ));
  }
}
