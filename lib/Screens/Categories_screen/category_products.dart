import 'package:ecommerce_app/Data/Bloc/Category_products/category_products_state.dart';
import 'package:ecommerce_app/Data/Model/Product/category_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shimmer/shimmer.dart';
import '../../Data/Bloc/Category_products/category_products_bloc.dart';
import '../../Data/Model/Product/product_model.dart';
import '../../widgets/like_button_widget.dart';
import '../../widgets/pop_effect.dart';
import '../detailed_screen.dart';

class CategoryProducts extends StatefulWidget {
  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text("Categories", style: style.headlineMedium),
              ),
              SizedBox(height: 10),
              BlocBuilder<CategoryProductBloc, CategoryProductsState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return GridView.builder(
                      padding: EdgeInsets.only(
                        top: 10,
                        left: 20,
                        right: 20,
                        bottom: 110,
                      ),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 250,
                        childAspectRatio: 9 / 10,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 14,
                      itemBuilder: (_, index) {
                        return Shimmer.fromColors(
                          baseColor: isDark
                              ? Colors.grey[800]!
                              : Colors.grey[300]!,
                          highlightColor: isDark
                              ? Colors.grey[700]!
                              : Colors.grey[100]!,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color:  Colors.white,
                            ),
                          ),
                        );
                      },
                    );
                  }
                  if (state is LoadedState) {
                    List<ProductModel> productModel = state.products;
                    return GridView.builder(
                      padding: EdgeInsets.only(
                        top: 10,
                        left: 20,
                        right: 20,
                        bottom: 110,
                      ),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 250,
                        childAspectRatio: 9 / 10,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: productModel.length,
                      itemBuilder: (_, index) {
                        ProductModel product = productModel[index];
                        return PopChild(
                          onTap: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: DetailedScreen(product:product ),
                              withNavBar: false,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: isDark ? Color(0xff2C2C2C) : Colors.white,
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  left: 10,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 10),
                                      Hero(
                                        tag: product.id,
                                        child: SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: Image.network(
                                            product.image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 160,
                                        child: Text(
                                          product.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: style.bodyMedium!.copyWith(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "₹${product.price}",
                                        style: style.titleLarge!.copyWith(
                                          fontSize: 18,
                                        ),
                                      ),
                                      /* Row(
                                          children: [
                                            Text(
                                              "M.R.P:",
                                              style: style.bodySmall,
                                            ),
                                            Text(
                                              "₹000}",
          
                                              style: style.bodySmall,
                                            ),
                                          ],
                                        ),*/
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 5,
                                  left: 10,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.red,
                                    ),
                                    child: Text(
                                      "%off",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "pop",
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      color: Color(0xff64B5F6),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                    ),
                                    child: LikeButton(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  if (state is FailureState) {
                    print("failure state is called");
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: style.headlineSmall,
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
