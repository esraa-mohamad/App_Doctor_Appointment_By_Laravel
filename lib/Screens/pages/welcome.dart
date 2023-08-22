import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:doctor_appointment/utils/config.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
             Color(0xff08527A),
              Color(0xff0E89CB),
              Color(0xff15A3EF),
              Color(0xff66C3F4),
              Color(0xffB7E3FA),
              Color(0xffC6E8FB),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/photo.png'),
              Config.smallSpacer,
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 60,
                  fontFamily: Config.primaryFont,
                  color: Colors.white
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    WavyAnimatedText('Your Doctor'),
                  ],
                  isRepeatingAnimation: true,
                  onTap: () {
                  },
                ),
              ),
              Config.smallSpacer,
              AvatarGlow(
                startDelay: const Duration(microseconds: 1000),
                glowColor: Config.primaryColor,
                endRadius: 50,
                child: IconButton(
                    onPressed: (){
                      Navigator.pushNamed(context, 'login');
                    },
                    icon: const Icon(
                      Icons.start,
                      size: 40,
                      color: Config.smallColorText,
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
