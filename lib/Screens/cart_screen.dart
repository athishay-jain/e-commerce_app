import 'dart:async';
import 'dart:ui';

import 'package:ecommerce_app/Data/Bloc/Cart/cart_bloc.dart';
import 'package:ecommerce_app/Data/Bloc/Cart/cart_event.dart';
import 'package:ecommerce_app/Data/Bloc/Cart/cart_state.dart';
import 'package:ecommerce_app/Data/Model/Product/cart_model.dart';
import 'package:ecommerce_app/Screens/check_out.dart';
import 'package:ecommerce_app/Utilities/wigets/error_widget.dart';
import 'package:ecommerce_app/widgets/pop_effect.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shimmer/shimmer.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(GetCart());
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 2.5),
      end: Offset(0, 1.1),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
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
        appBar: AppBar(
          title: Text("My Cart", style: style.headlineMedium),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                Widget child;
                if (state is LoadingState) {
                  child = ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) => Shimmer.fromColors(
                      child: Container(
                        height: 120,
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      baseColor: isDark
                          ? Colors.grey[800]!
                          : Colors.grey[300]!,
                      highlightColor: isDark
                          ? Colors.grey[700]!
                          : Colors.grey[100]!,
                    ),
                  );
                } else if (state is CartEmptyState) {
                  child = Column(
                   // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 80,),
                      Image.asset("assets/images/empty_cart.png"),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Your Cart is Empty",
                          style: style.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                } else if (state is FailureState) {
                  child = ErrorScreen(message: state.errorMessage);
                } 
                else if (state is LoadedState) {
                  List<CartModel> cartItems = state.cart;
                  child = ListView.builder(
                    padding: EdgeInsets.only(bottom: 400),
                    itemCount: cartItems.length,
                    itemBuilder: (_, index) {
                      return Container(
                        height: 120,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  child: Image.network(
                                    cartItems[index].image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 140,
                                        child: Text(
                                          cartItems[index].name,
                                          style: style.titleMedium!.copyWith(
                                            fontSize: 16,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "₹${cartItems[index].price}",
                                        style: style.titleLarge!.copyWith(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 5),
                                PopChild(
                                  onTap: () {
                                    context.read<CartBloc>().add(
                                      DeleteItem(
                                        cart_id: cartItems[index].id,
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 55,
                                    ),
                                    child: Icon(
                                      CupertinoIcons.delete_simple,
                                      color: Color(0xFF1E88E5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              right: 10,
                              bottom: 22,
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      context.read<CartBloc>().add(
                                        DecrementQty(
                                          quantity: 1,
                                          product_id:
                                              cartItems[index].product_id,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: isDark
                                            ? Colors.white
                                            : Colors.grey.shade200,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.remove_rounded,
                                        color: isDark
                                            ? Colors.black
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    color: isDark
                                        ? Colors.white
                                        : Colors.grey.shade200,
                                    child: Center(
                                      child: Text(
                                        cartItems[index].quantity.toString(),
                                        style: TextStyle(
                                          fontFamily: "pop",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: isDark
                                              ? Colors.black
                                              : Colors.black,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      context.read<CartBloc>().add(
                                        IncrementQty(
                                          quantity: 1,
                                          product_id:
                                              cartItems[index].product_id,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: isDark
                                            ? Colors.white
                                            : Colors.grey.shade200,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: isDark
                                            ? Colors.black
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } 
                else {
                  child = const SizedBox.shrink();
                }
                return AnimatedSwitcher(
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
                  child: child,
                );
              },
            ),

            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return SlideTransition(
                    position: _slideAnimation,
                    child: Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                        height: 380,
                        decoration: BoxDecoration(
                          color: isDark ? Color(0xff2C2C2C) : Color(0xffe8f5ff),
                          boxShadow: isDark
                              ? [
                                  BoxShadow(
                                    color: Color(0xaa3A3A3A),
                                    blurRadius: 15,
                                    spreadRadius: -5,
                                    offset: Offset(0, -8),
                                  ),
                                ]
                              : [
                                  BoxShadow(
                                    blurRadius: 10,
                                    color: Colors.black.withAlpha(50),
                                  ),
                                ],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: isDark
                                    ? Color(0xFF121212)
                                    : Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                hintText: "Enter Discount Code",
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "pop",
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    right: 15,
                                  ),
                                  child: Text(
                                    "Apply",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "pop",
                                      fontSize: 16,
                                      color: Color(0xFF1E88E5),
                                    ),
                                  ),
                                ),
                                //suffixStyle:  TextStyle(fontWeight: FontWeight.w500,fontFamily: "pop",color: Colors.black,fontSize: 16),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                SizedBox(width: 10),
                                Text(
                                  "Subtotal",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "pop",
                                    color: isDark
                                        ? Color(0xff90A4AE)
                                        : Colors.grey.shade700,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "₹00",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "pop",
                                    color: isDark
                                        ? Color(0xff90A4AE)
                                        : Colors.grey.shade700,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                                SizedBox(width: 10),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(height: 1, color: Colors.grey),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                SizedBox(width: 10),
                                Text(
                                  "Total",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "pop",
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "₹00",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "pop",
                                    color: Color(0xFF1E88E5),
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                                SizedBox(width: 10),
                              ],
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: CheckOut(),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF1E88E5),
                                minimumSize: Size(280, 50),
                              ),
                              child: isLoading
                                  ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "Checkout",
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontFamily: "pop",
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      "Checkout",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontFamily: "pop",
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                            /*BlocListener<CartBloc,CartState>(
                              listener: (context, state) {
                                if (state is OrderLoadingState) {
                                  isLoading = true;
                                  setState(() {});
                                }
                                if (state is OrderLoadedState) {
                                  isLoading = false;
                                  setState(() {});
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: CheckOut(),
                                  );
                                }
                              },
                              child: ElevatedButton(
                                onPressed: () {
                                  context.read<CartBloc>().add(
                                    PlaceOrder(cart_id: state.cart[1].id),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF1E88E5),
                                  minimumSize: Size(280, 50),
                                ),
                                child: isLoading
                                    ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "Checkout",
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontFamily: "pop",
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        "Checkout",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontFamily: "pop",
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),*/
                          ],
                        ),
                      ),
                    ),
                  );
                }
                if (state is LoadedState) {
                  _controller.forward();
                  return SlideTransition(
                    position: _slideAnimation,
                    child: Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                        height: 380,
                        decoration: BoxDecoration(
                          color: isDark ? Color(0xff2C2C2C) : Color(0xffe8f5ff),
                          boxShadow: isDark
                              ? [
                                  BoxShadow(
                                    color: Color(0xaa3A3A3A),
                                    blurRadius: 15,
                                    spreadRadius: -5,
                                    offset: Offset(0, -8),
                                  ),
                                ]
                              : [
                                  BoxShadow(
                                    blurRadius: 10,
                                    color: Colors.black.withAlpha(50),
                                  ),
                                ],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: isDark
                                    ? Color(0xFF121212)
                                    : Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                hintText: "Enter Discount Code",
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "pop",
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    right: 15,
                                  ),
                                  child: Text(
                                    "Apply",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "pop",
                                      fontSize: 16,
                                      color: Color(0xFF1E88E5),
                                    ),
                                  ),
                                ),
                                //suffixStyle:  TextStyle(fontWeight: FontWeight.w500,fontFamily: "pop",color: Colors.black,fontSize: 16),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                SizedBox(width: 10),
                                Text(
                                  "Subtotal",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "pop",
                                    color: isDark
                                        ? Color(0xff90A4AE)
                                        : Colors.grey.shade700,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "₹${state.totalAmount}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "pop",
                                    color: isDark
                                        ? Color(0xff90A4AE)
                                        : Colors.grey.shade700,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                                SizedBox(width: 10),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(height: 1, color: Colors.grey),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                SizedBox(width: 10),
                                Text(
                                  "Total",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "pop",
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "₹${state.totalAmount}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "pop",
                                    color: Color(0xFF1E88E5),
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                                SizedBox(width: 10),
                              ],
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                context.read<CartBloc>().add(
                                  PlaceOrder(cart_id: state.cart[0].id),
                                );
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: CheckOut(),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF1E88E5),
                                minimumSize: Size(280, 50),
                              ),
                              child: isLoading
                                  ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "Checkout",
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontFamily: "pop",
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      "Checkout",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontFamily: "pop",
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                            /*BlocListener<CartBloc,CartState>(
                              listener: (context, state) {
                                if (state is OrderLoadingState) {
                                  isLoading = true;
                                  setState(() {});
                                }
                                if (state is OrderLoadedState) {
                                  isLoading = false;
                                  setState(() {});
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: CheckOut(),
                                  );
                                }
                              },
                              child: ElevatedButton(
                                onPressed: () {
                                  context.read<CartBloc>().add(
                                    PlaceOrder(cart_id: state.cart[1].id),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF1E88E5),
                                  minimumSize: Size(280, 50),
                                ),
                                child: isLoading
                                    ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "Checkout",
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontFamily: "pop",
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        "Checkout",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontFamily: "pop",
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),*/
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
