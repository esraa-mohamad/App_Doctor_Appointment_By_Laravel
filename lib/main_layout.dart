import 'package:doctor_appointment/Screens/pages/appointment_page.dart';
import 'package:doctor_appointment/Screens/pages/fav_page.dart';
import 'package:doctor_appointment/Screens/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Screens/pages/profile_page.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

int currentPage = 0;
final _page = PageController();

class _MainLayoutState extends State<MainLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _page,
        onPageChanged: ((value) {
          setState(() {
            //update page index when onPressed
            currentPage = value;
          });
        }),
        //pages
        children: const [
          HomePage(),
          FavPage(),
          AppointPage(),
          ProfilePage(),

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.houseChimneyMedical),
              label: "Home"),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.solidHeart),
              label: "Favorite"),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.solidCalendarCheck),
              label: "Appointments"),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.solidUser),
              label: "Profile"),
        ],
        currentIndex: currentPage,
        onTap: (page) {
          setState(() {
            currentPage = page;
            _page.animateToPage(page,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut);
          });
        },
      ),
    );
  }
}
