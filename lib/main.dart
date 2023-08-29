import 'package:doctor_appointment/Screens/forms/auth_page.dart';
import 'package:doctor_appointment/Screens/pages/doctor_details.dart';
import 'package:doctor_appointment/Screens/pages/success_booking.dart';
import 'package:doctor_appointment/Screens/pages/welcome.dart';
import 'package:doctor_appointment/main_layout.dart';
import 'package:doctor_appointment/models/auth_model.dart';
import 'package:doctor_appointment/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

import 'Screens/pages/booking_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthModel>(
      create: (context) => AuthModel(),
      child:GetMaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'Flutter Doctor App',
        theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
            focusColor: Config.primaryColor,
            border: Config.outlinedBorder,
            focusedBorder: Config.focusBorder,
            errorBorder: Config.errorBorder,
            enabledBorder: Config.outlinedBorder,
            floatingLabelStyle: TextStyle(color: Config.primaryColor),
            prefixIconColor: Colors.black38,
          ),
          scaffoldBackgroundColor: Colors.white,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Config.primaryColor,
              selectedItemColor: Colors.white,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              unselectedItemColor: Colors.grey.shade700,
              elevation: 10,
              type: BottomNavigationBarType.fixed
          ),
          useMaterial3: true,
        ),
        //here is initial route which from it we will go to another screen
        initialRoute: 'welcome',
        routes: {
          'login': (context) => const AuthScreen(),
          'main': (context) => const MainLayout(),
          'welcome': (context) => const WelcomePage(),
          // 'doc_details': (context) => const DoctorDetails(),
          'booking': (context) => BookingPage(),
          'success_booking': (context) => SuccessBooking(),

        },
      ),
    );
  }
}

