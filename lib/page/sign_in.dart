import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc/auth_bloc.dart';
import 'home.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is Authenticated) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
      }
      if (state is AuthError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.error)));
      }
    }, builder: (context, state) {
      if (state is Loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is UnAuthenticated) {
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Sign In',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          return value != null &&
                                  !EmailValidator.validate(value)
                              ? 'Email chưa đúng định dạng'
                              : null;
                        },
                        controller: _emailController,
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
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          return value != null && value.length < 6
                              ? "Mật khẩu tối thiểu 6 kí tự"
                              : null;
                        },
                        controller: _passwordController,
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
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: const BorderSide(color: Colors.red))),
                          ),
                          onPressed: () {
                            _authenticateWithEmailAndPassword(context);
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
                              flex: 2,
                              child: Divider(color: Color(0xff34495e))),
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
          ),
        );
      }
      return Container();
    });
  }

  void _authenticateWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignInRequested(_emailController.text, _passwordController.text),
      );
    }
  }
}
