import 'package:doctor_appointment/components/button.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import '../../utils/config.dart';

class SuccessBooking extends  StatefulWidget {
  const SuccessBooking({super.key});

  @override
  State<SuccessBooking> createState() => _SuccessBookingState();
}

class _SuccessBookingState extends State<SuccessBooking> {
  @override
  Widget build(BuildContext context) {

    Config().init(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
        [
          Expanded(
            flex: 3,
              child:Lottie.asset('assets/images/animation_llcinhoi.json'),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              'Successfully Booked',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color:Config.primaryColor ,
                fontFamily: Config.primaryFont,
                fontSize: 25,
              ),
            ),
          ),
          Spacer(),
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15),
            child: ButtonForm(
              title: 'Back To Home Page',
              onPressed: (){
                Navigator.pushNamed(context, 'main');
              },
              width: double.infinity,
              disable: false,
            ),
          ),
        ],
      ),

    );
  }
}
