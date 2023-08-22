import 'package:flutter/material.dart';

import '../utils/config.dart';

class ButtonForm extends StatelessWidget {
  const ButtonForm(
      {Key? key, required this.width, required this.title, required this.disable, required this.onPressed})
      : super(key: key);
  final double width;
  final String title;
  final bool disable;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Config.primaryColor,
              foregroundColor: Colors.white
          ),
          onPressed: disable ? null : onPressed,
          child: Text(
            title, style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Inter',
            fontWeight: FontWeight.bold
          ),
          )),
    );
  }
}
