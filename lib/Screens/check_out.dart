import 'package:ecommerce_app/Screens/Profile_screens/Order_history.dart';
import 'package:flutter/material.dart';
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Lottie.asset("assets/Lottie/Order_completed.json",height: 200,width: 200),
          SizedBox(height: 20,),
            Text("Order Placed",style: style.headlineMedium,),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              PersistentNavBarNavigator.pushNewScreen(context, screen: OrderHistory());
            }, style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1E88E5)),
                child: Text("Go to Order",style: style.labelLarge,)),
          ],
        ),
      ),
    );
  }
}
