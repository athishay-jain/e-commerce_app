import 'package:ecommerce_app/Data/Bloc/User/user_bloc.dart';
import 'package:ecommerce_app/Data/Bloc/User/user_event.dart';
import 'package:ecommerce_app/Data/Bloc/User/user_state.dart';
import 'package:ecommerce_app/Data/Model/users/user_model.dart';
import 'package:ecommerce_app/Screens/Authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool showPass = true;
  bool check = false;
  RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void closeKeyboard(value) {
    FocusScope.of(context).unfocus();
  }

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
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Center(
                  child: Image.asset(
                    "assets/images/signup_image.png",
                    scale: 2,
                  ),
                ),
                Text("Create an account", style: style.headlineLarge),
                SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    onTapOutside: closeKeyboard,
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Name is required";
                      }
                      return null;
                    },
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
                  child: TextFormField(
                    maxLength: 10,
                    onTapOutside: closeKeyboard,
                    controller: phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Phone Number is required";
                      } else if (value.length != 10) {
                        return "Enter the valid phone number";
                      }
                      return null;
                      ;
                    },
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
                  child: TextFormField(
                    onTapOutside: closeKeyboard,
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      } else if (!emailRegex.hasMatch(value)) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
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
                      } else if (value.length < 8) {
                        return "Password must be eight characters";
                      }
                      ;
                      return null;
                    },
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
                    Checkbox(
                      value: check,
                      fillColor: WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.selected)) {
                          return Colors.blueAccent;
                        }
                        return null;
                      }),
                      onChanged: (value) {
                        check = value ?? false;
                        setState(() {});
                      },
                    ),
                    Text("I agree to the", style: style.bodyMedium),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Terms",
                        style: style.bodyMedium!.copyWith(
                          color: Color(0xff1E88E5),
                        ),
                      ),
                    ),
                    Text("and", style: style.bodyMedium),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Privacy Policy",
                        style: style.bodyMedium!.copyWith(
                          color: Color(0xff1E88E5),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18),
                BlocConsumer<UserBloc, UserState>(
                  builder: (context, state) {
                    return isLoading
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(
                                color: Color(0xff1E88E5),
                              ),
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
                                if (check) {
                                  context.read<UserBloc>().add(
                                    UserRegistrationEvent(
                                      userModel: UserModel(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                        mobileNumber: phoneController.text,
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Accept Terms and Conditions",
                                      ),
                                      backgroundColor: Colors.orange,
                                    ),
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff1E88E5),
                              minimumSize: Size(350, 55),
                            ),
                            child: Text(
                              "Signup",
                              style: style.labelLarge!.copyWith(fontSize: 20),
                            ),
                          );
                  },
                  listener: (context, state) {
                    if (state is UserLoadingState && state.isSignup) {
                      isLoading = true;
                    }
                    if (state is UserSuccessState && state.isSignup) {
                      isLoading = false;
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "SignUp Successful!! Now Login",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.green,
                        ),
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
                SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?", style: style.bodyMedium),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Login",
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
