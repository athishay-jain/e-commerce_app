import 'package:ecommerce_app/Utilities/Data/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {

ThemeProvider(){
loadTheme();
}

  String theme = "System";
VoidCallback callback=(){};
loadTheme()async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  theme = prefs.getString("theme") ?? "System";
  notifyListeners();
}

  void changeTheme({required String currentTheme}) async{
    theme = currentTheme;
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setString("theme", currentTheme);
    notifyListeners();
  }

  ThemeMode getTheme() {
   if(theme=="System"){
     return ThemeMode.system;
   }else if(theme =="Light"){
     return ThemeMode.light;
   }else{
     return ThemeMode.dark;
   }
  }
}
