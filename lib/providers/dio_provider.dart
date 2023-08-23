import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctor_appointment/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioProvider{
  //this is to get token
  Future<dynamic> getToken(String email, String password) async {
    try {
      var response = await Dio().post('${Config.ip}/api/login',
          data: {'email': email, 'password': password},options: Options(receiveTimeout:Duration(seconds: 15),));
      if (response.statusCode == 200 && response.data != '') {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.data);
        return true;
      }else{
        
        return false;

      }
    }catch(error){
      return error;
    }
    }


//    let`s get user data

  Future<dynamic> getUser(String token) async {
    try {
      var user = await Dio().get('${Config.ip}/api/user', options: Options(headers: {'Authorization': 'Bearer $token'},receiveTimeout:Duration(seconds: 15),));
      if (user.statusCode == 200 && user.data != '') {
        return json.encode(user.data);
      }
    } catch (error) {
      return error;
    }
  }

  //register new user
  Future<dynamic> registerUser(String username,String email,String password) async {
    try {
      var user = await Dio().post('${Config.ip}/api/register', data: {'name':username,'email': email, 'password': password});
      if (user.statusCode == 200 && user.data != '') {
        return true;
      }else{
        return false;
      }
    } catch (error) {
      return error;
    }
  }
}