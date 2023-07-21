import 'dart:convert';

import 'package:beegain/config/config.dart';
import 'package:beegain/models/enquiry/enquiry_model.dart';
import 'package:http/http.dart' as http;

class ApiRepository {
  var client = http.Client();

  onEnquiry(
      {required token,
      required String fdate,
      required tdate,
      required fid}) async {
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
      };
      String params =
          "page=1&franchise_id=$fid&search=&from_date=$fdate&to_date=$tdate&est_status="
          "&jobcards=0";

      String url = "${Config.enquiryUrl}?$params";

      var res = await client.get(Uri.parse(url), headers: headers);
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);

        return {"status": "ok", "data": Enq.fromJson(body['data'])};
      } else {
        return {"status": "failed", "message": "!200"};
      }
    } catch (e) {
      return {"status": "failed", "message": "some server error occured"};
    }
  }
}

//?page=1&franchise_id=2&search=""&from_date=""&to_date=""&est_status=""&jobcards=0'

//page=1&franchise_id=2&search=""&from_date=""&to_date=""&est_status=""&jobcards=0 