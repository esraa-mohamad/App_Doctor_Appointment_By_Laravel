import 'package:dio/dio.dart';
import 'package:doctor_appointment/components/button.dart';
import 'package:doctor_appointment/main.dart';
import 'package:doctor_appointment/models/auth_model.dart';
import 'package:doctor_appointment/providers/dio_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/config.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool obSecure = true;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
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
              builder: (context,auth,child) {
                return ButtonForm(
                    width: double.infinity,
                    title: "sign In",
                    disable: false,
                  onPressed: () async {
                      // final token=await Dio2Provider().get2Token(_emailController.text, _passwordController.text);
                      // print(token);
                    var token = await DioProvider().getToken(
                        _emailController.text, _passwordController.text);

                    if (token is bool) {
                      if (token) {
                        auth.loginSuccess();
                        MyApp.navigatorKey.currentState!.pushNamed('main');
                      } else {
                        print("Login failed");
                      }
                    } else if (token is String) { // Check for a string error message
                      print("Error occurred: $token");
                      // Handle the error, such as showing an error message to the user.
                    } else {
                      print("Error exception : $token");
                    }
                  },
                );
              },
            ),
          ],
        ));
  }
}
