import 'package:ecommerce_app/Utilities/wigets/theme_selector.dart';
import 'package:flutter/material.dart';

class AppSettings extends StatefulWidget {
  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  bool notificationSwitch = false;

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [Color(0xFF121212), Color(0xFF1E1E1E)]
              : [Color(0xFFe3f2fd), Color(0xFFbbdefb)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Settings",
            style: theme.headlineMedium!.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        body: ListView(
          children: [
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                "Preferences",
                style: theme.headlineMedium!.copyWith(fontSize: 20),
              ),
            ),
            SizedBox(height: 8),
            /*Padding(
  padding: const EdgeInsets.only(left: 16.0),
  child: Text("Theme",style: theme.bodyLarge,),
),*/
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ThemeSelector()],
            ),
            ListTile(
              title: Text(
                "Language",
                style: theme.bodyLarge,
              ),
              subtitle: Text("English", style: theme.bodySmall),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            ListTile(
              title: Text(
                "Push Notification",
                style: theme.bodyLarge,
              ),
              trailing: Switch(
                value: notificationSwitch,
                onChanged: (value) {
                  notificationSwitch = value;
                  setState(() {});
                },
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                "Legal",
                style: theme.headlineMedium!.copyWith(fontSize: 20),
              ),
            ),
            SizedBox(height: 8),
            ListTile(
              title: Text(
                "Terms & Conditions",
                style: theme.bodyLarge,
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            ListTile(
              title: Text(
                "Privacy Policy",
                style: theme.bodyLarge),

              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                "Support",
                style: theme.headlineMedium!.copyWith(fontSize: 20),
              ),
            ),
            SizedBox(height: 8),
            ListTile(
              title: Text(
                "Help Center",
                style: theme.bodyLarge,
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            ListTile(
              title: Text(
                "Contact Us",
                style: theme.bodyLarge,
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                "App Information",
                style: theme.headlineMedium!.copyWith(fontSize: 20),
              ),
            ),
            SizedBox(height: 8),
            ListTile(
              title: Text(
                "About App",
                style: theme.bodyLarge,
              ),
              subtitle: Text("Version 1.2.3",style: theme.bodySmall,),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
