import 'package:ecommerce_app/Data/Bloc/Order/order_bloc.dart';
import 'package:ecommerce_app/Data/Bloc/Order/order_event.dart';
import 'package:ecommerce_app/Data/Bloc/Order/order_state.dart';
import 'package:ecommerce_app/Data/Model/Product/Order_model.dart';
import 'package:ecommerce_app/widgets/pop_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<OrderBloc>().add(GetOrderHistory());
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
          centerTitle: true,
          title: Text(
            "Order History",
            style: style.headlineMedium!.copyWith(fontWeight: FontWeight.w500),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            return AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              transitionBuilder: (child, animation) => FadeTransition(opacity: animation,child: child,),
              child: (){
                if (state is LoadedState) {
                  List<OrderResponseModel> response = state.orderData;
                  return ListView.builder(
                    key: ValueKey("loaded"),
                    itemCount: response.length,
                    itemBuilder: (context, index) {
                      OrderResponseModel order = response[index];
                      return GestureDetector(
                        onTap: () {
                          selectedIndex = index;
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 16,
                          ),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(20),
                            border: isDark
                                ? Border.all(color: Color(0xFF404040), width: 1)
                                : null,
                            boxShadow: isDark
                                ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 20,
                                spreadRadius: 2,
                                offset: Offset(0, 8),
                              ),
                              BoxShadow(
                                color: Color(0xFF3A3A3A).withAlpha(150),
                                blurRadius: 15,
                                spreadRadius: -5,
                                offset: Offset(0, -8),
                              ),
                            ]
                                : [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                spreadRadius: 2,
                                offset: Offset(0, 8),
                              ),
                              BoxShadow(
                                color: Colors.white.withAlpha(150),
                                blurRadius: 15,
                                spreadRadius: -5,
                                offset: Offset(0, -8),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Order ${order.orderNumber}",
                                    style: style.headlineSmall!.copyWith(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${DateFormat("dd-MM-yyyy").format(DateTime.parse(order.createdAt))}",
                                    style: style.bodySmall!.copyWith(fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    "${order.product.length} Items",
                                    style: style.bodySmall!.copyWith(fontSize: 18),
                                  ),
                                  Spacer(),
                                  Text(
                                    "₹${double.parse(order.totalAmount).toInt()}",
                                    style: style.titleLarge!.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AnimatedRotation(
                                    turns: selectedIndex == index ? 0 : 0.5,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeIn,
                                    child: Icon(
                                      Icons.keyboard_arrow_up_outlined,
                                      size: 30,
                                      color: isDark
                                          ? Color(0xff90A4AE)
                                          : Color(0xff757575),
                                    ),
                                  ),

                                  ///   SizedBox(width: 10),
                                  Expanded(
                                    child: AnimatedCrossFade(
                                      firstChild: SizedBox(
                                        height: 50,
                                        child: ListView.builder(
                                          itemCount: order.product.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, secondIndex) =>
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                  horizontal: 5,
                                                ),
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      order
                                                          .product[secondIndex]
                                                          .image,
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  color: Theme.of(
                                                    context,
                                                  ).cardColor,
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: isDark
                                                        ? Color(0xFF404040)
                                                        : Colors.grey,
                                                  ),
                                                ),
                                              ),
                                        ),
                                      ),
                                      secondChild: ListView.builder(
                                        itemCount: order.product.length,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, secIndex) => ListTile(
                                          leading: Container(
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 5,
                                            ),
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  order.product[secIndex].image,
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              color: Theme.of(context).cardColor,
                                              borderRadius: BorderRadius.circular(
                                                10,
                                              ),
                                              border: Border.all(
                                                color: isDark
                                                    ? Color(0xFF404040)
                                                    : Colors.grey,
                                              ),
                                            ),
                                          ),
                                          title: Text(
                                            order.product[secIndex].name,
                                            style: style.bodyLarge,
                                          ),
                                          subtitle: Text(
                                            "Quantity:${order.product[secIndex].quantity}",
                                            style: style.bodySmall,
                                          ),

                                          trailing: Text(
                                            "₹${order.product[secIndex].price}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                      crossFadeState: selectedIndex == index
                                          ? CrossFadeState.showSecond
                                          : CrossFadeState.showFirst,
                                      duration: Duration(milliseconds: 400),
                                      sizeCurve: Curves.easeIn,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                if (state is LoadingState) {
                  return ListView.builder(
                    key: ValueKey("loading"),
                    itemCount: 6,
                    itemBuilder: (context, index) => Shimmer.fromColors(
                      baseColor: isDark
                          ? Colors.grey[800]!
                          : Colors.grey[300]!,
                      highlightColor: isDark
                          ? Colors.grey[700]!
                          : Colors.grey[100]!,
                      child: Container(
                        height: 190,
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  );
                }
                if (state is FailureState) {}
                return Container();
              }(),
            );
          },
        ),
      ),
    );
  }
}
