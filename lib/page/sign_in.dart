import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week4_food_delivery/bloc/app_bloc.dart';

import 'home.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        final bloc = context.read<AppBloc>();
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
          ),
          body: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 30.0, right: 30.10, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Sign In',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: bloc.email,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 30.0, top: 20, bottom: 20),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide.none),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          hintText: "Username",
                          fillColor: const Color(0xFFECF0F1)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: bloc.password,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 30.0, top: 20, bottom: 20),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide.none),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          hintText: "Password",
                          fillColor: const Color(0xFFECF0F1)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xFFD35400)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      side:
                                          const BorderSide(color: Colors.red))),
                        ),
                        onPressed: () {
                          bloc.add(AppSignIn(
                              email: bloc.email.text,
                              password: bloc.password.text));

                          {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Home()));
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Sign In",
                            style: TextStyle(fontSize: 27),
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Forgot Password?',
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                            flex: 2, child: Divider(color: Color(0xff34495e))),
                        Expanded(
                            child: Column(
                          children: [
                            const Text(
                              "Or connect with",
                              textAlign: TextAlign.center,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.facebook_outlined,
                                  color: Colors.blue,
                                  size: 40,
                                ),
                                Icon(
                                  Icons.g_mobiledata,
                                  color: Colors.red,
                                  size: 40,
                                )
                              ],
                            )
                          ],
                        ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
