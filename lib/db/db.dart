import 'dart:convert';
import 'dart:developer';

import 'package:beegain/models/auth/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DbService {
  //// insert to db

  Future setUser(AuthModel data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(
        'user',
        jsonEncode({
          "name": data.data.user.userName,
          "token": data.data.token,
          "fid": data.data.user.employee.franchiseId
        }));

    log("inserted to db");
  }

  // check

  Future<bool> checkIuser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return !prefs.containsKey('user') || prefs.getString('user')!.isEmpty;
  }

  // get user ifo

  Future<String> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("user") ?? "";
  }

  Future clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
