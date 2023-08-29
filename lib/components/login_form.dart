import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctor_appointment/components/button.dart';
import 'package:doctor_appointment/main.dart';
import 'package:doctor_appointment/models/auth_model.dart';
import 'package:doctor_appointment/providers/dio_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              builder: (context, auth, child) {
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
                        // auth.loginSuccess();
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        final tokenValue = prefs.getString('token') ?? '';
                        if (tokenValue.isNotEmpty && token != '') {
                          try {
                            final response =
                                await DioProvider().getUser(tokenValue);
                            if (response != null) {
                              // ignore: deprecated_member_use
                              if (response is DioError) {
                                // Handle DioException
                                // Get.snackbar(
                                //     'DioException:', '${response.message}');

                              } else if (response is String) {
                                setState(() {
                                  Map<String, dynamic> appointment = {};
                                  var user = json.decode(response);
                                  for (var doctorData in user['doctor']) {
                                    if (doctorData['appointments'] != null) {
                                      appointment = doctorData;
                                    }
                                  }
                                  auth.loginSuccess(user, appointment);
                                  MyApp.navigatorKey.currentState!
                                      .pushNamed('main');
                                  Get.snackbar(
                                    'Login Successfully',
                                    'Feel free to book appointment',
                                    snackPosition: SnackPosition.TOP,
                                    backgroundColor: Colors.green, // Customize the background color
                                    colorText: Colors.white,     // Customize the text color
                                  );
                                });
                              } else {
                                print('Unexpected response type');
                              }
                            }
                          } catch (error) {
                            print('An error occurred: $error');
                          }
                        }
                      } else {
                        Get.snackbar(
                          'Login Failed',
                          'Wrong email or password',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red, // Customize the background color
                          colorText: Colors.white,     // Customize the text color
                        );
                      }
                    } else if (token is String) {
                      // Check for a string error message
                      print("Error occurred: $token");
                      // Handle the error, such as showing an error message to the user.
                    } else {
                      Get.snackbar(
                        'Login Failed',
                        'Wrong email or password',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red, // Customize the background color
                        colorText: Colors.white,     // Customize the text color
                      );
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
