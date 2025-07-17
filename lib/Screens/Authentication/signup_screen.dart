import 'package:ecommerce_app/Screens/Authentication/login_screen.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool showPass = true;
  bool check=false;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    TextTheme style = Theme.of(context).textTheme;
    // TODO: implement build
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Center(
                child: Image.asset(
                  "assets/images/signup_image.png",
                  scale: 1.8,
                ),
              ),
              Text("Create an account", style: style.headlineLarge),
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
                    hintText: "Name",
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
                    hintText: "Phone Number",
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
                  obscureText: showPass,
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
                    suffixIcon: IconButton(
                      onPressed: () {
                        showPass = !showPass;
                        setState(() {});
                      },
                      icon: showPass
                          ? Icon(Icons.visibility_outlined)
                          : Icon(Icons.visibility_off_outlined),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(value: check,
                  fillColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return Colors.blueAccent;
                    }
                  }),
                      onChanged: (value){
                    check = value??false;
                    setState(() {
                    });
                  }),
                  Text("I agree to the",style: style.bodyMedium,),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen(),));
                    },
                    child: Text(
                      "Terms",
                      style: style.bodyMedium!.copyWith(color: Color(0xff1E88E5)),
                    ),
                  ),
                  Text("and",style: style.bodyMedium,),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen(),));
                    },
                    child: Text(
                      "Privacy Policy",
                      style: style.bodyMedium!.copyWith(color: Color(0xff1E88E5)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff1E88E5),
                  minimumSize: Size(350, 55),
                ),
                child: Text(
                  "Signup",
                  style: style.labelLarge!.copyWith(fontSize: 20),
                ),
              ),
              SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?", style: style.bodyMedium),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                    },
                    child: Text(
                      "Login",
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
