import 'package:doctor_appointment/components/button.dart';
import 'package:doctor_appointment/main.dart';
import 'package:doctor_appointment/models/auth_model.dart';
import 'package:doctor_appointment/providers/dio_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/config.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool obSecure = true;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              cursorColor: Config.primaryColor,
              decoration: const InputDecoration(
                  hintText: "Username",
                  labelText: "username",
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.person_outline),
                  prefixIconColor: Config.primaryColor),
            ),
            Config.smallSpacer,
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Config.primaryColor,
              decoration: const InputDecoration(
                  hintText: "Email address",
                  labelText: "Email",
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.email_outlined),
                  prefixIconColor: Config.primaryColor),
            ),
            Config.smallSpacer,
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              cursorColor: Config.primaryColor,
              obscureText: obSecure,
              decoration: InputDecoration(
                  hintText: "Password",
                  labelText: "Password",
                  alignLabelWithHint: true,
                  prefixIcon: const Icon(Icons.lock_outline),
                  prefixIconColor: Config.primaryColor,
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obSecure = !obSecure;
                        });
                      },
                      icon: obSecure
                          ? const Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.black38,
                            )
                          : const Icon(
                              Icons.visibility_outlined,
                              color: Config.primaryColor,
                            ))),
            ),
            Config.smallSpacer,
            Consumer<AuthModel>(
              builder: (context, auth, child) {
                return ButtonForm(
                    width: double.infinity,
                    title: "sign Up",
                    disable: false,
                    onPressed: () async {
                      final email = _emailController.text;
                      final password = _passwordController.text;

                      if (email.isNotEmpty && password.isNotEmpty) {
                        try {
                          await DioProvider().registerUser(
                              _nameController.text, email, password
                          );

                          try {
                            final token = await DioProvider().getToken(email, password);

                            if (token != null) {
                              // Update login status
                              auth.loginSuccess();
                              MyApp.navigatorKey.currentState!.pushNamed('main');
                            } else {
                              print('Failed to get token.');
                            }
                          } catch (error) {
                            // Handle token retrieval error here
                            print('Failed to get token: $error');
                          }
                        } catch (error) {
                          // Handle user registration error here
                          print('User registration failed: $error');
                        }
                      } else {
                        print('Email and password cannot be empty.');
                      }
                    }
                    );
              },
            ),
          ],
        ));
  }
}
