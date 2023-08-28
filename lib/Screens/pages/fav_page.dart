import 'package:doctor_appointment/components/doctor_card.dart';
import 'package:doctor_appointment/utils/config.dart';
import 'package:flutter/material.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20,right: 20,top: 20),
          child: Column(
            children: [
              Text(
                'My Favorite Doctor',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: Config.primaryFont,
                  color: Config.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: ListView.builder(
                      itemBuilder: (context,index){
                        return DoctorCard(
                            route: 'doc_details',
                            doctor: {}
                        );
                      }
                  )
              ),
            ],
          ),
        )
    );
  }
}
