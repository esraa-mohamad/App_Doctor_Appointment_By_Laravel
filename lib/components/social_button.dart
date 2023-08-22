import 'package:doctor_appointment/utils/config.dart';
import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({Key? key, required this.social, required this.ontap}) : super(key: key);
  final String social;
  final Function() ontap;
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
            side: const BorderSide(
              width: 1,
              color: Colors.black
            )),
        onPressed:ontap,
        child: SizedBox(
          width: Config.widthSize *0.4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/images/$social.png',
                width: 40,
                height: 40,
              ),
              Text(
                social.toUpperCase(),
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ));
  }
}
