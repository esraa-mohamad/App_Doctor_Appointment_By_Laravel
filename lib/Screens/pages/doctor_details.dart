import 'package:doctor_appointment/components/button.dart';
import 'package:doctor_appointment/components/custome_appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/config.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({super.key});

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {

  bool isFav=false;
  @override
  Widget build(BuildContext context) {
    //get arguments passed from doctor card
    final doctor=ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    return Scaffold(
      appBar: CustomeApp(
        tabTitle: 'Doctor Details',
        icon: FaIcon(Icons.arrow_back_ios),
        actions: [
          IconButton(
              onPressed: (){
                setState(() {
                  isFav=!isFav;
                });
              },
              icon: FaIcon(isFav? Icons.favorite_rounded:Icons.favorite_outline,
                color: Colors.red,
              ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            AboutDoctor(doctor: doctor,),
            DetailBody(doctor: doctor),
            Spacer(),
            Padding(
                padding: EdgeInsets.all(10),
              child: ButtonForm(
                width: double.infinity,
                title: 'Book Appointment',
                disable: false,
                onPressed: ()
                {
                  Navigator.pushNamed(context, 'booking');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// about doctor reusable widget
class  AboutDoctor extends StatelessWidget {
  const AboutDoctor({super.key, required this.doctor});
  final Map<String,dynamic>doctor;
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
              '${Config.ip}${doctor['doctor_profile']}',
            ),
            backgroundColor: Config.textColor,
          ),
          Config.smallSpacer,
          Text(
            'Dr ${doctor['doctor_name']}',
            style: TextStyle(
              fontSize: 24,
              color: Config.primaryColor,
              fontFamily: Config.primaryFont,
              fontWeight: FontWeight.bold
            ),
          ),
          Config.smallSpacer,
          SizedBox(
            width: Config.widthSize*0.75,
            child: Text(
              'MBBS (Doctor in Medical universal , Benha)',
              style: TextStyle(
                fontSize: 15,
                fontFamily: Config.fontText,
                color: Config.textColor,

              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          Config.smallSpacer,
          SizedBox(
            width: Config.widthSize*0.75,
            child: Text(
              'Benha General Hospital',
              style: TextStyle(
                fontSize: 14,
                fontFamily: Config.fontText,
                color: Config.smallColorText,
                fontWeight: FontWeight.bold
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),

        ],
      ),
    );
  }
}

// more info of doctor widget
class DetailBody extends StatelessWidget {
  const DetailBody({super.key, required this.doctor});
  final Map<String,dynamic>doctor;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:
        [
          Config.smallSpacer,
          DoctorInfo(patients: doctor['patients'],exp: doctor['experience'],),
          Config.smallSpacer,
          Text(
              'About Doctor',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: Config.primaryFont,
            color: Config.primaryColor
          ),
          ),
          Config.smallSpacer,
          Text(
            'Dr ${doctor['doctor_name']} is graduated from Benha university , and training in many hospital  , he is popular ${doctor['category']} and teaching for many students',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              fontFamily: Config.fontText,
              color: Colors.grey,
              height: 1.5
            ),
            softWrap: true,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}

// details of info of doctor widget
class DoctorInfo extends StatelessWidget {
  const DoctorInfo({super.key, required this.patients, required this.exp});
  final int patients;
  final int exp;
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Row(
      children:
      [
        InfoCard(
            label: 'Patient',
            value: '$patients',
        ),
        SizedBox(
          width: 15,
        ),
        InfoCard(
          label:'Experiences',
          value: '$exp Years',
        ),
        SizedBox(
          width: 15,
        ),
        InfoCard(
          label: 'Rate',
          value: '4.5',
        ),
      ],
    );
  }
}


// variable for info card  of doctor
class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.label, required this.value});

  final String label;
  final String value ;
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Expanded(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Config.primaryColor,
          ),
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          child: Column(
            children:
            [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontFamily: Config.primaryFont,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: Config.fontText,
                ),
              ),
            ],
          ),
        )
    );
  }
}

