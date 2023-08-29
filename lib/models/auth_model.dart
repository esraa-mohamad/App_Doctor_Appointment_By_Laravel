import 'dart:convert';

import 'package:flutter/material.dart';

class AuthModel extends ChangeNotifier {

  bool _isLogin = false;

  Map<String,dynamic> user={};
  Map<String,dynamic> appointment={};
  List<Map<String, dynamic>> favDoc = [];
  List<dynamic> _fav = [];

  bool get login{
    return _isLogin;
  }

  List<dynamic> get getFav {
    return _fav;
  }

  Map<String, dynamic> get getUser {
    return user;
  }

  Map<String, dynamic> get getAppointment {
    return appointment;
  }

  //this is to update latest favorite list and notify all widgets
  void setFavList(List<dynamic> list) {
    _fav = list;
    notifyListeners();
  }

//and this is to return latest favorite doctor list
  List<Map<String, dynamic>> get getFavDoc {
    favDoc.clear(); //clear all previous record before get latest list

    //list out doctor list according to favorite list
    for (var num in _fav) {
      for (var doc in user['doctor']) {
        if (num == doc['doc_id']) {
          favDoc.add(doc);
        }
      }
    }
    return favDoc;
  }
   void loginSuccess(Map<String, dynamic> userData, Map<String, dynamic> appointmentInfo){
    _isLogin=true;

    user = userData;
    appointment = appointmentInfo;
    if (user['details']['fav'] != null) {
      _fav = json.decode(user['details']['fav']);
    }

    notifyListeners();

   }
}