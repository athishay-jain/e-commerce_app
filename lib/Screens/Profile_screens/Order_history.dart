import 'package:ecommerce_app/Data/Bloc/Order/order_bloc.dart';
import 'package:ecommerce_app/Data/Bloc/Order/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key});

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
            body:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16,top: 16),
                  child: Text("Order History",style: style.headlineMedium,),
                ),
                SizedBox(height: 10,),
                BlocBuilder<OrderBloc,OrderState>(builder: (context, state) {
                  if(state is LoadingState){}
                  if(state is LoadedState){}
                  if(state is FailureState){}
                  return Container();
                  },)
              ],
            ),),);
  }
}
