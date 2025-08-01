import 'dart:async';

import 'package:ecommerce_app/Screens/Onboarding/ob_boarding.dart';
import 'package:ecommerce_app/Screens/dashboard_screen.dart';
import 'package:ecommerce_app/Utilities/Data/app_constants.dart';
import 'package:ecommerce_app/Utilities/Data/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String id='' ;

  void prefId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString(AppConstants.userToken) ?? "";
    print("User token is :${preferences.getString(AppConstants.userToken)}");
    Timer(
      Duration(milliseconds: 100),
          () => Navigator.pushNamed(
        context,
        id.isEmpty ? AppRoutes.loginScreen : AppRoutes.dashBoardScreen,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prefId();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E88E5),
      /* body: Center(
        child: Image.asset("assets/images/vertical_logo.png", scale: 3),
      ),*/
    );
  }
}
