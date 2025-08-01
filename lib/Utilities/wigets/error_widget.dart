import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  String message;

ErrorScreen({required this.message});
  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isDark
            ? Image.asset("assets/images/error_dark.png")
            : Image.asset("assets/images/error_light.png"),
        SizedBox(height: 20),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(message, style: theme.headlineMedium,textAlign: TextAlign.center,)),
      ],
    );
  }
}
