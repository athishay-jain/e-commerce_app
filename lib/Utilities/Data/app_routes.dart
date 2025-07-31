import 'package:ecommerce_app/Screens/Authentication/login_screen.dart';
import 'package:ecommerce_app/Screens/Authentication/signup_screen.dart';
import 'package:ecommerce_app/Screens/Categories_screen/category_products.dart';
import 'package:ecommerce_app/Screens/Profile_screens/Order_history.dart';
import 'package:ecommerce_app/Screens/Profile_screens/app_settings.dart';
import 'package:ecommerce_app/Screens/cart_screen.dart';
import 'package:ecommerce_app/Screens/dashboard_screen.dart';
import 'package:ecommerce_app/Screens/detailed_screen.dart';
import 'package:ecommerce_app/Screens/home_screen.dart';
import 'package:ecommerce_app/Screens/profile_screen.dart';
import 'package:ecommerce_app/Screens/spalsh_screen.dart';
import 'package:flutter/cupertino.dart';

class AppRoutes {
  static const String splashScreen = "/";
  static const String loginScreen = "/login";
  static const String signUpScreen = "/signUp";
  static const String dashBoardScreen = "/dashboard";
  static const String homeScreen = "/home";
  static const String detailedScreen = "/detailed";
  static const String cartScreen = "/cart";
  static const String profileScreen = "/profile";
  static const String appSettingScreen = "/appSetting";
  static const String categoryProductScreen = "/CategoryProductScreen";
  static const String oderHistoryScreen = "/oderHistoryScreen";

  Map<String, WidgetBuilder> routes = {
    splashScreen: (_) => SplashScreen(),
    loginScreen: (_) => LoginScreen(),
    signUpScreen: (_) => SignupScreen(),
    dashBoardScreen: (_) => DashboardScreen(),
    homeScreen: (_) => HomeScreen(),
    // detailedScreen:(_)=>DetailedScreen(product: ),
    cartScreen: (_) => CartScreen(),
    profileScreen: (_) => ProfileScreen(),
    appSettingScreen: (_) => AppSettings(),
    categoryProductScreen:(_)=>CategoryProducts(),
    oderHistoryScreen:(_)=>OrderHistory(),
  };
}
