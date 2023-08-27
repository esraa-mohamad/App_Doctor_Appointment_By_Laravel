import 'dart:convert';

import 'package:doctor_appointment/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/dio_provider.dart';

class AppointPage extends StatefulWidget {
  const AppointPage({Key? key}) : super(key: key);

  @override
  State<AppointPage> createState() => _AppointPageState();
}

enum FilterStatus { upcoming, complete, cancel }

class _AppointPageState extends State<AppointPage> {
  FilterStatus status = FilterStatus.upcoming;
  Alignment _alignment = Alignment.centerLeft;
  List<dynamic> schedules = [];

  Future<void> getAppointments() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final appointment = await DioProvider().getAppointments(token);
    if (appointment != 'Error') {
      setState(() {
        schedules = json.decode(appointment);
      });
    }
  }

  @override
  void initState() {
    getAppointments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> filteredSchedules = schedules.where((var schedule) {
      switch(schedule['status']){
        case 'upcoming':
          schedule['status']=FilterStatus.upcoming;
          break;
        case 'complete':
          schedule['status']=FilterStatus.complete;
          break;
        case 'cancel':
          schedule['status']=FilterStatus.cancel;
          break;
      }
      return schedule['status'] == status;
    }).toList();
    return SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Appointment Schedules",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Config.primaryColor,
              fontFamily: Config.primaryFont
            ),
          ),
          Config.smallSpacer,
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //this is a filter tabs here to show status bro !!
                    for (FilterStatus filterStatus in FilterStatus.values)
                      Expanded(
                          child: GestureDetector(
                            onTap: () {
                          setState(() {
                            if (filterStatus == FilterStatus.upcoming) {
                              status = FilterStatus.upcoming;
                              _alignment = Alignment.centerLeft;
                            } else if (filterStatus == FilterStatus.complete) {
                              status = FilterStatus.complete;
                              _alignment = Alignment.center;
                            } else if (filterStatus == FilterStatus.cancel) {
                              status = FilterStatus.cancel;
                              _alignment = Alignment.centerRight;
                            }
                          });
                        },
                            child: Center(
                             child: Text(
                                 filterStatus.name,
                               style: TextStyle(
                                 fontWeight: FontWeight.w600,
                                 fontFamily: Config.fontText,
                               ),
                             ),
                        ),
                      ))
                  ],
                ),
              ),
              AnimatedAlign(
                alignment: _alignment,
                duration: Duration(milliseconds: 200),
                child: Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Config.primaryColor),
                  child: Center(
                    child: Text(
                      status.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Config.smallSpacer,
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) {
              var schedule = filteredSchedules[index];
              bool isLast = filteredSchedules.length + 1 == index;
              return Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: !isLast ? EdgeInsets.only(bottom: 20) : EdgeInsets.zero,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage("${Config.ip2}${schedule['doctor_profile']}"),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                schedule['doctor_name'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                schedule['category'],
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                       ScheduleCard(
                         date: schedule['date'],
                         day: schedule['day'],
                         time: schedule['time'],
                       ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                                onPressed: () {},
                                child: Text(
                                  "cancel",
                                  style: TextStyle(color: Config.primaryColor),
                                )),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: Config.primaryColor),
                                onPressed: () {},
                                child: Text(
                                  "Reschedule",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: filteredSchedules.length,
          )),
        ],
      ),
    ));
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key, required this.date, required this.day, required this.time});
  final String date;
  final String day;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child:  Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.calendar_today,
              color: Config.primaryColor,
              size: 15,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              '$day $date',
              style: TextStyle(
                  color: Config.primaryColor,
                  fontFamily: Config.fontText
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.access_alarm,
              color: Config.primaryColor,
              size: 17,
            ),
            SizedBox(
              width: 3,
            ),
            Flexible(
              child: Text(
                time,
                style: TextStyle(
                  fontFamily: Config.fontText,
                  color: Config.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
