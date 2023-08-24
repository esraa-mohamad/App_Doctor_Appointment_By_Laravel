import 'package:doctor_appointment/components/button.dart';
import 'package:doctor_appointment/components/custome_appbar.dart';
import 'package:doctor_appointment/models/booking_datetime_converted.dart';
import 'package:doctor_appointment/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../main.dart';
import '../../providers/dio_provider.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {

  CalendarFormat _format =CalendarFormat.month;
  DateTime _focusTime = DateTime.now();
  DateTime _currentTime = DateTime.now();
  int? _currentIndex;
  bool? _isWeekend =false;
  bool? _dateSelected = false;
  bool? _timeSelected = false;
  String? token;

  Future<void> getToken() async
  {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
  }


  @override
  void initState() {
    getToken();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    final doctor = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: CustomeApp(
        tabTitle: 'Appointments',
        icon: FaIcon(Icons.arrow_back_ios),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children:
              [
                _tableCalender(),

                Center(
                  child: Text(
                    'Select Consultation Time',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: Config.primaryFont,
                      color: Config.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _isWeekend!?
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 30),
              alignment: Alignment.center,
              child: Text(
                'Weekend is not available , please select another day',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontFamily: Config.fontText
                ),
              ),
            ),
          ):
          SliverGrid(
              delegate: SliverChildBuilderDelegate((context,index){
                return InkWell(
                  splashColor: Colors.transparent,
                  onTap: (){
                    setState(() {
                      _currentIndex=index;
                      _timeSelected=true;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _currentIndex == index
                            ? Colors.white
                            : Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      color: _currentIndex == index
                        ?Config.primaryColor
                          : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${index+9} : 00 ${index+9 > 11 ? "PM" : "AM"}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _currentIndex == index
                          ? Colors.white
                            : null,
                      ),
                    ),
                  ),
                );
              },
              childCount: 8
              ),

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 1.5,
              )
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 50),
              child: ButtonForm(
                width: double.infinity,
                title: 'Make Appointment',
                onPressed: () async {
                  final getDate =DateConverted.getDate(_currentTime);
                  final getDay=DateConverted.getDay(_currentTime.weekday);
                  final getTime=DateConverted.getTime(_currentIndex!);

                  final booking = await DioProvider().bookAppointment(
                      getDate,
                      getDay,
                      getTime,
                      doctor['doctor_id'],
                      token!,
                  );

                  if(booking == 200)
                    {
                      MyApp.navigatorKey.currentState!.pushNamed('success_booking');
                    }

                },
                disable: _timeSelected! && _dateSelected!
                    ? false
                    :true,
              ),
            ),
          )
        ],
      ),
    );
  }

  // table of calender

  Widget _tableCalender()
  {
    return TableCalendar(
        focusedDay: _focusTime,
        firstDay: DateTime.now(),
        lastDay: DateTime(2024,01,01),
      calendarFormat: _format,
      currentDay: _currentTime,
      rowHeight: 48,
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Config.primaryColor,
          shape: BoxShape.circle
        ),

      ),
      availableCalendarFormats: {
          CalendarFormat.month:'Month',
      },
      onFormatChanged: (format){
          setState(() {
            _format=format;
          });
      },
      onDaySelected: (selectedDay , focusDay)
      {
        setState(() {
          _currentTime=selectedDay;
          _focusTime=focusDay;
          _dateSelected=true;
          if(selectedDay.weekday==6 || selectedDay.weekday ==7)
            {
              _isWeekend=true;
              _timeSelected=false;
              _currentIndex=null;
            }
          else
            {
              _isWeekend=false;
            }
        });
      },
      calendarBuilders: CalendarBuilders(
        // Customize the day cell's style based on selected day
        selectedBuilder: (context, date, focusedDay) {
          if (_currentIndex != null && date == _currentTime) {
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Config.primaryColor,
                shape: BoxShape.circle,
              ),
              child: Text(
                '${date.day}',
                style: TextStyle(color: Colors.white),
              ),
            );
          } else {
            return null;
          }
        },
      ),
    );
  }
}


