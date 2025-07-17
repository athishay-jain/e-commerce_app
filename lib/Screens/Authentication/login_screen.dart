import 'package:ecommerce_app/Screens/Authentication/signup_screen.dart';
import 'package:ecommerce_app/Screens/main_page.dart';
import 'package:ecommerce_app/widgets/pop_effect.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    TextTheme style = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

          colors: isDark
              ? [Color(0xFF121212), Color(0xFF1E1E1E)]
              : [Color(0xFFe3f2fd), Color(0xFFbbdefb)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
          child: Column(
            children: [
              Image.asset("assets/images/login_image.png", scale: 2),
              Text("Welcome Back", style: style.headlineLarge),
              SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  style: style.bodySmall!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    fillColor: Theme.of(context).cardColor,
                    hintText: "Email",
                    hintStyle: style.bodySmall!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  style: style.bodySmall!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    fillColor: Theme.of(context).cardColor,
                    hintText: "Password",
                    hintStyle: style.bodySmall!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: TextButton(
                    onPressed: () {},
                    child: Text("Forgot Password?", style: style.bodyMedium),
                  ),
                ),
              ),
              SizedBox(height: 18),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage(),));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff1E88E5),
                  minimumSize: Size(350, 55),
                ),
                child: Text(
                  "Login",
                  style: style.labelLarge!.copyWith(fontSize: 20),
                ),
              ),
              SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width / 2.5,
                    color: isDark ? Colors.white : Color(0xff2C2C2C),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text("OR", style: style.titleSmall),
                  ),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width / 2.5,
                    color: isDark ? Colors.white : Color(0xff2C2C2C),
                  ),
                ],
              ),
              SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PopChild(
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Image.asset(
                        "assets/images/icons/google_ic.png",
                        scale: 6,
                      ),
                    ),
                  ),
                  SizedBox(width: 45),
                  PopChild(
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Align(
                        alignment: Alignment(0, -0.3),
                        child: Image.asset(
                          "assets/images/icons/apple_ic.png",
                          scale: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?", style: style.bodyMedium),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen(),));
                    },
                    child: Text(
                      "Signup",
                      style: style.bodyMedium!.copyWith(color: Color(0xff1E88E5)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
