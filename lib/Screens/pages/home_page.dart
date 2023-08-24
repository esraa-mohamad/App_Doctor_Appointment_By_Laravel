import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctor_appointment/components/appointment_card.dart';
import 'package:doctor_appointment/components/doctor_card.dart';
import 'package:doctor_appointment/providers/dio_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/config.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String,dynamic>user={};
  List <Map<String,dynamic>> medCat=[
    {
      'icon':FontAwesomeIcons.userDoctor,
      'category':'General',
    },
    {
      'icon':FontAwesomeIcons.heartPulse,
      'category':'Cardiology',
    },
    {
      'icon':FontAwesomeIcons.lungs,
      'category':'Respiration',
    },
    {
      'icon':FontAwesomeIcons.hand,
      'category':'Dermatology',
    },
    {
      'icon':FontAwesomeIcons.personPregnant,
      'category':'Gynecology',
    },
    {
      'icon':FontAwesomeIcons.teeth,
      'category':'Dental',
    },
  ];

  Future<void> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    if (token.isNotEmpty && token != '') {
      try {
        final response = await DioProvider().getUser(token);
        if (response != null) {
          setState(() {
            user = json.decode(response);
            print(user);
          });
        }
      } on DioException catch (e) {
        // Handle DioException here
        print('DioException: ${e.message}');
      }
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return   Scaffold(
      body:user.isEmpty?const Center(child: CircularProgressIndicator())
          :SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
             child: SingleChildScrollView(
               child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      user['name'],
                      style:const  TextStyle(
                        fontSize: 24,
                        fontFamily: Config.primaryFont,
                        color: Config.primaryColor,
                      ),
                    ),
                    const SizedBox(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/medical.png'),
                      ),
                    )
                  ],
                ),
                Config.inBetweenSpacer,
                const Text(
                  'Category',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: Config.primaryFont,
                      color: Config.smallColorText,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Config.smallSpacer,
                SizedBox(
                  height: Config.heightSize*0.05,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(medCat.length, (index)
                    {
                      return Card(
                        margin: const EdgeInsets.only(right: 20),
                        color: Config.primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FaIcon(
                                medCat[index]['icon'],
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                medCat[index]['category'],
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: Config.fontText,
                                    fontWeight: FontWeight.w500
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                    ),
                  ),
                ),
                Config.smallSpacer,
                const Text(
                  'Appointment Today',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: Config.primaryFont,
                      color: Config.smallColorText,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Config.smallSpacer,
                const AppointmentCard(),
                Config.smallSpacer,
                const Text(
                  'Top Doctor',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: Config.primaryFont,
                      color: Config.smallColorText,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Config.smallSpacer,
                Column(
                  children: List.generate(user['doctor'].length, (index)
                  {
                    return  DoctorCard(
                      route: 'doc_details', doctor:user['doctor'][index],
                    );
                  }
                  ),
                )
              ],
            ),
          ),
         ),
      ),
    );
  }
}
