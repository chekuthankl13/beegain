import 'dart:async';

import 'package:beegain/config/config.dart';
import 'package:beegain/db/db.dart';
import 'package:beegain/presentation/auth/login_screen.dart';
import 'package:beegain/presentation/home/home_screen.dart';
import 'package:beegain/utils/utills.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () async {
      bool isUser = await DbService().checkIuser();
      if (isUser) {
        navigatorKey.currentState!.pushReplacement(MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
      } else {
        var user = await DbService().getUser();
        navigatorKey.currentState!.pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Config().baseclr,
        ),
      ),
    );
  }
}
