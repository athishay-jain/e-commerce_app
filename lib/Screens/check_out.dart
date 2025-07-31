import 'package:ecommerce_app/Data/Bloc/Cart/cart_bloc.dart';
import 'package:ecommerce_app/Data/Bloc/Cart/cart_state.dart';
import 'package:ecommerce_app/Screens/Profile_screens/Order_history.dart';
import 'package:ecommerce_app/Screens/home_screen.dart';
import 'package:ecommerce_app/Utilities/Data/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class CheckOut extends StatelessWidget {
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Image.asset("assets/images/app_icon_horizonal.png"),
          leadingWidth: 180,
        ),
        body: BlocBuilder<CartBloc,CartState>(builder: (context, state) {
          if(state is OrderLoadingState){
            Center(child: CircularProgressIndicator(color: Colors.blueAccent,),);
          }
          if(state is OrderLoadedState){
            return Center(
              child: Column(
                children: [
                 state.success? Lottie.asset("assets/Lottie/Order_completed.json",):Lottie.asset("assets/Lottie/order_fail.json",height: 200,width: 200),
                  SizedBox(height: 20,),
                  Text(state.message,style: style.headlineMedium,),
                  SizedBox(height: 70,),
                  ElevatedButton(onPressed: (){
                  //  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen(),),(Route<dynamic>route)=>false);
                    Navigator.pushReplacementNamed(context, AppRoutes.dashBoardScreen);
                  }, style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1E88E5),fixedSize: Size(250, 50)),
                      child: Text("Home Screen",style: style.labelLarge!.copyWith(fontSize: 23),)),
                ],
              ),
            );
          }
          return Container();
        },)
      ),
    );
  }
}
