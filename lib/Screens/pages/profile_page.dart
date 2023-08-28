import 'package:doctor_appointment/main.dart';
import 'package:doctor_appointment/providers/dio_provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/config.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            width: double.infinity,
            color: Config.textColor,
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                CircleAvatar(
                  radius: 65,
                  backgroundImage: AssetImage('assets/images/photo.png'),
                  backgroundColor: Colors.white,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Esraa Mohamed',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: Config.primaryFont,
                      color: Config.primaryColor),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '21 Years | Female',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: Config.smallFontText,
                      color: Config.smallColorText),
                ),
              ],
            ),
          ),
        ),
        Expanded(
            flex: 5,
            child: Container(
              color: Config.smallColorText,
              child: Center(
                child: Card(
                  margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Container(
                    width: 310,
                    height: 300,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Text(
                            'Profile',
                            style: TextStyle(
                                fontFamily: Config.primaryFont,
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                                color: Config.primaryColor),
                          ),
                          Divider(
                            color: Colors.grey[300],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.person,
                                color: Config.primaryColor,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Profile',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Config.smallFontText,
                                      color: Config.primaryColor,
                                    ),
                                  )),
                            ],
                          ),
                          Config.smallSpacer,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.history,
                                color: Colors.yellow,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'History',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Config.smallFontText,
                                      color: Config.primaryColor,
                                    ),
                                  )),
                            ],
                          ),
                          Config.smallSpacer,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.login_outlined,
                                color: Config.smallColorText,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              TextButton(
                                  onPressed: () async {
                                    final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    final token =
                                        prefs.getString('token') ?? '';
                                    if (token.isNotEmpty && token != '') {
                                      final response = await DioProvider().logout(token);
                                      if(response==200){
                                        await prefs.remove('token');
                                        setState(() {
                                          MyApp.navigatorKey.currentState!.pushReplacementNamed('/login');
                                        });
                                      }
                                    }
                                  },
                                  child: Text(
                                    'Logout',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Config.smallFontText,
                                      color: Config.primaryColor,
                                    ),
                                  )),
                            ],
                          ),
                          Config.smallSpacer,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
