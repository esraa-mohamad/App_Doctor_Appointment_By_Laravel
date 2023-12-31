import 'package:doctor_appointment/Screens/pages/doctor_details.dart';
import 'package:doctor_appointment/main.dart';
import 'package:doctor_appointment/utils/config.dart';
import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key, required this.doctor, required this.isFav});

  final Map<String,dynamic>doctor;
  final bool isFav;
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return  Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      height: 150,
      child: GestureDetector(
        onTap: (){
          // Navigator.pushNamed(context, route,arguments: doctor);
          MyApp.navigatorKey.currentState!.push(MaterialPageRoute(builder: (_)=>DoctorDetails(doctor: doctor,isFav: isFav,)));
        },
        child: Card(
          elevation: 5,
          color: Colors.white,
          child: Row(
            children: [
              SizedBox(
                width: Config.widthSize*0.33,
                child: Image.network(
                  '${Config.ip}${doctor['doctor_profile']}',
                  fit: BoxFit.fill,),
              ),
              Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Dr ${doctor['doctor_name']}",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: Config.primaryFont,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          '${doctor['category']}',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: Config.fontText,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                                Icons.star_border,
                              color: Colors.yellow,
                              size: 16,
                            ),
                            Spacer(flex: 1),
                            Text('4.5'),
                            Spacer(flex: 1),
                            Text('Reviews'),
                            Spacer(flex: 1),
                            Text('(20)'),
                            Spacer(flex: 7,)
                          ],
                        ),
                      ],
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
