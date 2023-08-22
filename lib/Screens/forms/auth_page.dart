import 'package:doctor_appointment/components/login_form.dart';
import 'package:doctor_appointment/components/sign_up_form.dart';
import 'package:doctor_appointment/components/social_button.dart';
import 'package:doctor_appointment/utils/config.dart';
import 'package:doctor_appointment/utils/text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isSignIn = true;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
        body: Padding(padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: SafeArea(
            child: Column(
              children: [
            Flexible(
                child: ListView(
                  children: [
                    Text(
                      AppText.enText["welcome_text"]!,
                      style: const TextStyle(
                          fontSize: 36,
                          fontFamily: Config.primaryFont,
                          color: Config.primaryColor),
                    ),
                    Config.smallSpacer,
                    Text(
                      isSignIn
                          ? AppText.enText["signIn_text"]!
                          : AppText.enText["register_text"]!,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: Config.smallFontText,
                          color: Config.smallColorText),
                    ),
                    Config.smallSpacer,
                    isSignIn ? LoginForm() : SignUp(),
                    Config.smallSpacer,
                    isSignIn
                        ? Center(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          AppText.enText["forget_pass"]!,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Config.smallColorText,
                              fontFamily: Config.smallFontText),
                        ),
                      ),
                    )
                        : Container(),
                    Center(
                      child: Text(
                        AppText.enText["social_login"]!,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.shade500),
                      ),
                    ),
                    Config.smallSpacer,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SocialButton(
                          social: 'facebook',
                          ontap: () {
                            launchUrlString('https://web.facebook.com');
                          },
                        ),
                        SocialButton(
                            social: 'google',
                            ontap: () {
                              launchUrlString('https://www.google.com.eg/?hl=ar');
                            }),
                      ],
                    ),
                    Config.smallSpacer,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isSignIn
                              ? AppText.enText["sighUp_text"]!
                              : AppText.enText["registered_text"]!,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade500),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              isSignIn = !isSignIn;
                            });
                          },
                          child: Text(
                            isSignIn ? ' Sign Up' : 'Sign In',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Config.smallColorText,
                              fontFamily: Config.primaryFont
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
            ),
            ],
        ),
          ),
    ));
  }
}
