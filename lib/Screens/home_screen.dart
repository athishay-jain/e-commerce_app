import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/Data/Bloc/Cart/cart_bloc.dart';
import 'package:ecommerce_app/Data/Bloc/Cart/cart_event.dart';
import 'package:ecommerce_app/Data/Bloc/Categories/Categories_bloc.dart';
import 'package:ecommerce_app/Data/Bloc/Categories/Categories_event.dart';
import 'package:ecommerce_app/Data/Bloc/Categories/Categories_state.dart';
import 'package:ecommerce_app/Data/Bloc/Category_products/category_products_bloc.dart';
import 'package:ecommerce_app/Data/Bloc/Product/product_bloc.dart';
import 'package:ecommerce_app/Data/Bloc/Product/product_event.dart';
import 'package:ecommerce_app/Data/Bloc/Product/product_state.dart';
import 'package:ecommerce_app/Data/Bloc/User/user_bloc.dart';
import 'package:ecommerce_app/Data/Bloc/User/user_event.dart';
import 'package:ecommerce_app/Data/Bloc/User/user_state.dart';
import 'package:ecommerce_app/Data/Model/Product/categories_model.dart';
import 'package:ecommerce_app/Data/Model/Product/product_model.dart';
import 'package:ecommerce_app/Screens/Categories_screen/category_products.dart';
import 'package:ecommerce_app/Screens/detailed_screen.dart';
import 'package:ecommerce_app/Utilities/Data/app_routes.dart';
import 'package:ecommerce_app/Utilities/wigets/error_widget.dart';
import 'package:ecommerce_app/widgets/like_button_widget.dart';
import 'package:ecommerce_app/widgets/pop_effect.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shimmer/shimmer.dart';

import '../Data/Bloc/Category_products/category_products_event.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> banners = [
    "assets/images/hero/electronics_img.png",
    "assets/images/hero/homeApplicances.png",
    "assets/images/hero/watch.png",
  ];
  List<Map<String, dynamic>> categoriesItems = [
    {
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4HOlYCk5n1XJ0KjnBrxAniNRbmyjxY6xogA&s",
      "name": "fridge"
    },
    {
      "image": "https://crystalpng.com/wp-content/uploads/2025/05/lenovo-logo.png",
    },
    {
      "image": "https://1000logos.net/wp-content/uploads/2017/02/Apple-Logosu.png",
    },
    {"image": "https://pngimg.com/uploads/samsung_logo/samsung_logo_PNG8.png",},
    {
      "image": "https://www.unboxify.in/cdn/shop/products/51zL2U_3bDL._SL1200.jpg?v=1694963807",
    },
    {
      "image": "https://saudewala.in/cdn/shop/collections/Laptop.jpg?v=1732216115&width=1296",
      "name": "Washing Machine"
    },
    {
      "image": "https://media.tatacroma.com/Croma%20Assets/Computers%20Peripherals/Tablets%20and%20iPads/Images/308032_eo0iwq.png",
      "name": "Washing Machine"
    },
    {
      "image": "https://www-cdn.djiits.com/cms/uploads/ae5d8b9987be8d5ecdeb5d502a1e887c.png",
      "name": "Washing Machine"
    },
  ];
  int _currentBanner = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProductBloc>().add(LoadInitialProducts());
    context.read<CategoriesBloc>().add(LoadCategoriesEvent());
    context.read<UserBloc>().add(GetUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    TextTheme style = Theme
        .of(context)
        .textTheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

          colors: isDark
              ? [Color(0xFF121212), Color(0xFF1E1E1E)]
              : [Color(0xFFe3f2fd), Color(0xFFbbdefb)],
          // colors: [Color(0xFF121212), Color(0xFF252561)],
          //colors: [Color(0xFF0D47A1), Color(0xFF1A237E)],
          // colors: [Color(0xFF121212),Color(0xFF0D47A1) ],
        ),
      ),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: Image.asset("assets/images/app_icon_horizonal.png"),
            leadingWidth: 180,
            actions: [],
            actionsPadding: EdgeInsets.only(right: 20),
          ),
          backgroundColor: Colors.transparent,
          body: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              Widget child;
              if (state is ProductsFailureState) {
                child = ErrorScreen(message: state.errorMessage);
              } else {
                child = SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20, top: 16),
                        child: BlocBuilder<UserBloc, UserState>(
                            builder: (context, state) {
                              Widget child;
                              if (state is UserLoadedState) {
                                child = Text("Hello,${state.user.name}👋",
                                    style: style.headlineLarge);
                              }
                              else {
                                child = const SizedBox.shrink();
                              }
                              return AnimatedSwitcher(
                                switchInCurve: Curves.easeIn,
                                switchOutCurve: Curves.easeOut,
                                duration: const Duration(milliseconds: 500),
                                transitionBuilder: (child, animation) =>
                                    FadeTransition(
                                        opacity: animation, child: child),
                                child: child,
                              );
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
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
                              color: Color(0xaa3A3A3A),
                              blurRadius: 15,
                              spreadRadius: -5,
                              offset: Offset(0, -8),
                            ),
                          ]
                              : [
                            BoxShadow(
                              color: isDark
                                  ? Color(0xff424242)
                                  : Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextField(
                          style: style.bodySmall!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: isDark
                                ? Color(0xff1E1E1E)
                                : Colors.white.withAlpha(140),
                            prefixIcon: Icon(
                              CupertinoIcons.search,
                              color: isDark ? Color(0xff78909C) : Color(
                                  0xff757575),
                            ),
                            suffixIcon: Icon(
                              CupertinoIcons.camera_viewfinder,
                              color: isDark ? Color(0xff78909C) : Color(
                                  0xff757575),
                              size: 30,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 15),
                            hintText: "Search",
                            hintStyle: style.bodySmall!.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      CarouselSlider.builder(
                        itemCount: banners.length,
                        itemBuilder: (context, index, realIdx) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: isDark
                                      ? Color(0xff424242)
                                      : Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                              image: DecorationImage(
                                image: AssetImage(banners[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          height: 200,
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentBanner = index;
                            });
                          },
                        ),
                      ),

                      // Dots (below Carousel)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: banners
                            .asMap()
                            .entries
                            .map((entry) {
                          return GestureDetector(
                            onTap: () =>
                                _carouselController.animateToItem(entry.key),
                            child: Container(
                              width: _currentBanner == entry.key ? 20 : 8.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 4.0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: _currentBanner == entry.key
                                    ? isDark
                                    ? Colors.grey
                                    : Colors.white
                                    : isDark
                                    ? Colors.grey.withOpacity(0.5)
                                    : Colors.white.withOpacity(0.5),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("Categories",
                                style: style.headlineMedium),
                          ),
                          Spacer(),
                          Text(
                            "More",
                            style: TextStyle(
                              color: Color(0xff1E88E5),
                              fontWeight: FontWeight.w500,
                              fontFamily: "pop",
                              fontSize: 15,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Color(0xff1E88E5),
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                      BlocBuilder<CategoriesBloc, CategoriesState>(
                        builder: (context, state) {
                          if (state is LoadingState) {
                            return SizedBox(
                              height: 160,
                              child: ListView.builder(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                scrollDirection: Axis.horizontal,
                                itemCount: categoriesItems.length,
                                itemBuilder: (_, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: PopChild(
                                      child: Shimmer.fromColors(
                                        child: CircleAvatar(
                                          radius: 40,
                                          backgroundColor: Colors.white,
                                          backgroundImage: AssetImage(
                                            categoriesItems[index]["image"],
                                          ),
                                        ),
                                        baseColor: isDark
                                            ? Colors.grey[800]!
                                            : Colors.grey[300]!,
                                        highlightColor: isDark
                                            ? Colors.grey[700]!
                                            : Colors.grey[100]!,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                          if (state is FailureState) {
                            return Center(child: Text(state.errorMessage,),);
                          }
                          if (state is LoadedState) {
                            List<CategoriesModel> catData = state.categories;
                            return SizedBox(
                              height: 160,
                              child: ListView.builder(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                scrollDirection: Axis.horizontal,
                                itemCount: catData.length,
                                itemBuilder: (_, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: Column(
                                      children: [
                                        PopChild(
                                          onTap: () {
                                            context
                                                .read<CategoryProductBloc>()
                                                .add(LoadProducts(
                                                cat_id: catData[index].id));
                                            PersistentNavBarNavigator
                                                .pushNewScreen(context,
                                                screen: CategoryProducts());
                                          },
                                          child: CircleAvatar(
                                            radius: 40,
                                            backgroundColor: isDark
                                                ? Color(0xff2C2C2C)
                                                : Colors.white,
                                            backgroundImage: NetworkImage(
                                              categoriesItems[index]["image"],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 6),
                                        SizedBox(
                                          width: 80,
                                          child: Text(
                                            catData[index].name,
                                            style: style.bodyLarge,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("For you", style: style.headlineMedium),
                          ),
                          Spacer(),
                          Text(
                            "See all",
                            style: TextStyle(
                              color: Color(0xff1E88E5),
                              fontWeight: FontWeight.w500,
                              fontFamily: "pop",
                              fontSize: 15,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Color(0xff1E88E5),
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, state) {
                          if (state is ProductsLoadingState) {
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
                              itemCount: 5,
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
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                          if (state is ProductsLoadedState) {
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
                              itemCount: 5,
                              itemBuilder: (_, index) {
                                ProductModel product = productModel[index];
                                return PopChild(
                                  onTap: () {
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: DetailedScreen(
                                          product: productModel[index]),
                                      withNavBar: false,
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: isDark ? Color(0xff2C2C2C) : Colors
                                          .white,
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
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  style: style.bodyMedium!
                                                      .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                "₹${product.price}",
                                                style: style.titleLarge!
                                                    .copyWith(
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
                                              borderRadius: BorderRadius
                                                  .circular(10),
                                              color: Colors.red,
                                            ),
                                            child: Text(
                                              "0%off",
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
                          if (state is ProductsFailureState) {
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
                );
              }
              return AnimatedSwitcher(duration: Duration(milliseconds: 600),
                transitionBuilder: (child, animation) {
                  return FadeTransition(opacity: animation, child: child,);
                },child: child,);
            },)
      ),
    );
  }
}
