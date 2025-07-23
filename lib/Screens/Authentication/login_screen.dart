import 'package:ecommerce_app/Data/Bloc/User/user_bloc.dart';
import 'package:ecommerce_app/Data/Bloc/User/user_event.dart';
import 'package:ecommerce_app/Data/Bloc/User/user_state.dart';
import 'package:ecommerce_app/Screens/Authentication/signup_screen.dart';
import 'package:ecommerce_app/Screens/dashboard_screen.dart';
import 'package:ecommerce_app/Utilities/Data/app_routes.dart';
import 'package:ecommerce_app/widgets/pop_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool isObscure = true;

  RegExp emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void closeKeyboard(value) {
    FocusScope.of(context).unfocus();
  }

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
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom,
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Image.asset("assets/images/login_image.png", scale: 2),
                Text("Welcome Back", style: style.headlineLarge),
                SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    onTapOutside: closeKeyboard,
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      } else if (!emailRegExp.hasMatch(value)) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
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
                  child: TextFormField(
                    onTapOutside: closeKeyboard,
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is required";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    style: style.bodySmall!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    obscureText: isObscure,
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
                          isObscure = !isObscure;
                          setState(() {});
                        },
                        icon: AnimatedCrossFade(
                          firstChild: Icon(Icons.visibility_off_outlined),
                          secondChild: Icon(Icons.visibility_outlined),
                          crossFadeState: isObscure
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          duration: Duration(milliseconds: 500),
                        ),
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
                BlocConsumer<UserBloc, UserState>(
                  builder: (context, state) => isLoading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(color: Color(0xff1E88E5)),
                            SizedBox(width: 10),
                            Text(
                              "Loading",
                              style: style.headlineMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        )
                      : ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<UserBloc>().add(
                                UserLoginEvent(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
                            }
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
                  listener: (context, state) {
                    if (state is UserLoadingState && state.isSignup==false) {
                      isLoading = true;
                    }
                    if (state is UserSuccessState && state.isSignup==false) {
                      isLoading = false;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "User Login Successfully",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.dashBoardScreen,
                      );
                    }
                    if (state is UserFailureState) {
                      isLoading = false;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.errorMessage,
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
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
                        Navigator.pushNamed(context, AppRoutes.signUpScreen);
                      },
                      child: Text(
                        "Signup",
                        style: style.bodyMedium!.copyWith(
                          color: Color(0xff1E88E5),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
