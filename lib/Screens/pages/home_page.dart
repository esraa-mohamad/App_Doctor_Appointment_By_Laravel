import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctor_appointment/components/appointment_card.dart';
import 'package:doctor_appointment/components/doctor_card.dart';
import 'package:doctor_appointment/providers/dio_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/auth_model.dart';
import '../../utils/config.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String,dynamic>user={};
  Map<String,dynamic>doctor={};
  List<dynamic> favList=[];
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
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    user = Provider.of<AuthModel>(context, listen: false).getUser;
    doctor = Provider.of<AuthModel>(context, listen: false).getAppointment;
    favList = Provider.of<AuthModel>(context, listen: false).getFav;
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
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: Config.primaryColor,
                          size: 50,
                        ),
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
               doctor.isNotEmpty?
               AppointmentCard(
                   doctor: doctor,
                   color: Config.primaryColor,
                 ) :
               Container(
                 width: double.infinity,
                 decoration: BoxDecoration(
                   color: Colors.grey.shade300,
                   borderRadius: BorderRadius.circular(12),
                 ),
                 child: Center(
                   child: Padding(
                     padding: EdgeInsets.all(20),
                     child: Text(
                       '  No Appointments Today',
                       style: TextStyle(
                         color: Config.smallColorText,
                         fontFamily: Config.smallFontText,
                         fontWeight: FontWeight.bold,
                         fontSize: 25,
                       ),
                     ),
                   ),
                 ),
               ),
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
                    return  DoctorCard(doctor:user['doctor'][index],
                        isFav:favList.contains(user['doctor'][index]['doc_id']) ? true : false,
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
