import 'package:flutter/material.dart';

class Config {
  static MediaQueryData? mediaQueryData;
  static double? scWidth;
  static double? scHeight;

  //initialization of width & height
  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    scWidth = mediaQueryData!.size.width;
    scHeight = mediaQueryData!.size.height;
  }

  //here we get width
  static get widthSize {
    return scWidth;
  }

  //here we get height
  static get heightSize {
    return scHeight;
  }

//  define Spacing here to make it easy to read and make it reusable (as we know don`t repeat your self )
  static const smallSpacer = SizedBox(
    height: 25,
  );
  static final inBetweenSpacer = SizedBox(
    height: scHeight! * 0.05,
  );
  static final largeSpacer = SizedBox(
    height: scHeight! * 0.08,
  );

//  here we arrange textFormField borders
static const outlinedBorder=OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10)),
  borderSide: BorderSide(color: Color(0xff0E41B0)),
);

//for focus border
  static const focusBorder=OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: Color(0xff0E41B0)),
  );

  //for error border
  static const errorBorder=OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: Colors.red),
  );

  static const primaryColor=Color(0xff0E41B0);

  static const primaryFont='Playfair Display';

  static const smallColorText=Color(0xff0B6DA2);

  static const textColor=Color(0xff66C3F4);

  static const smallFontText='Montserrat';

  static const fontText='Inter';

  static const ip = 'http://192.168.1.7:8000';

  static const ip2 = 'http://192.168.1.7:8000';

}
