import 'package:flutter/material.dart';

import '../utils/config.dart';

class AppointmentCard extends StatefulWidget {
  const AppointmentCard({super.key, required this.doctor, required this.color});

  final Map<String, dynamic> doctor;
  final Color color;
  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(10),
      ),
      child:  Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
               Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage("${Config.ip}${widget.doctor['doctor_profile']}"),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr. ${widget.doctor['doctor_name']}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: Config.primaryFont,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        widget.doctor['category'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: Config.smallFontText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Config.smallSpacer,
               ScheduleCard(
                 appointment: widget.doctor['appointments'],
               ),
              Config.smallSpacer,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                        onPressed: ()
                        {},
                        child: const Text(
                            'Cancel',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: Config.fontText
                          )
                        ),
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: (){},
                      child: const Text(
                          'Complete',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: Config.fontText
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

    );
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key, required this.appointment});
  final Map<String, dynamic> appointment;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child:  Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today,
              color: Colors.white,
                size: 15,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              '${appointment['day']} ,${appointment['date']}',
              style: TextStyle(
                color: Colors.white,
                fontFamily: Config.fontText
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.access_alarm,
              color: Colors.white,
              size: 17,
            ),
            SizedBox(
              width: 5,
            ),
            Flexible(
                child: Text(
                  appointment['time'],
                  style: TextStyle(
                    color: Colors.white
                  ),
            ),
            ),

          ],
        ),
      ),
    );
  }
}

