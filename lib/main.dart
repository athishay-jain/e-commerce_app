import 'package:ecommerce_app/Screens/Onboarding/ob_boarding.dart';
import 'package:ecommerce_app/Screens/main_page.dart';
import 'package:ecommerce_app/Screens/spalsh_screen.dart';
import 'package:ecommerce_app/Utilities/theme_helper.dart';
import 'package:ecommerce_app/Utilities/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
ChangeNotifierProvider(create: (context) {
  return ThemeProvider();
},)
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, value, child) {
      return MaterialApp(
        themeMode:value.getTheme(),
        theme: ThemeHelper().lightTheme(),
        darkTheme: ThemeHelper().darkTheme(),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      );
    },);
  }
}
