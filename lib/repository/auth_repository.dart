import 'dart:convert';

import 'package:beegain/config/config.dart';
import 'package:beegain/models/auth/auth_model.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  var client = http.Client();

  Future login({required name, required psw}) async {
    try {
      Map params = {"username": name, "password": psw};
      var res = await client.post(Uri.parse(Config.loginUrl), body: params);
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        if (body['success'] == "false") {
          return {"status": "failed", "data": body['message']};
        } else {
          return {"status": "ok", "data": AuthModel.fromJson(body)};
        }
      } else {
        return {"status": "failed", "message": "!200"};
      }
    } catch (e) {
      return {"status": "failed", "message": "some server error occured"};
    }
  }
}
