import 'package:flutter/material.dart';

class Config {
  static const baseUrl = "http://143.110.181.12:7070/api/";

  /// login

  static const loginUrl = "${baseUrl}login";

  /// enquiry

  static const enquiryUrl =
      "${baseUrl}get_enquiries?page=1&franchise_id=2&search=";

  /// color

  Color baseclr = const Color.fromARGB(255, 39, 66, 107);
}
