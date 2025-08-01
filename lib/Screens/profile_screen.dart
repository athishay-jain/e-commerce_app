import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/Data/Bloc/User/user_bloc.dart';
import 'package:ecommerce_app/Data/Bloc/User/user_event.dart';
import 'package:ecommerce_app/Data/Bloc/User/user_state.dart';
import 'package:ecommerce_app/Screens/Profile_screens/Order_history.dart';
import 'package:ecommerce_app/Screens/Profile_screens/app_settings.dart';
import 'package:ecommerce_app/Utilities/Data/app_constants.dart';
import 'package:ecommerce_app/widgets/pop_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<UserBloc>().add(GetUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color icColor = isDark ? Colors.white : Colors.black;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [Color(0xFF121212), Color(0xFF1E1E1E)]
              : [Color(0xFFe3f2fd), Color(0xFFbbdefb)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Profile", style: theme.headlineMedium),
          backgroundColor: Colors.transparent,
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            Widget child;

            if (state is UserLoadedState) {
              child = ListView(
                key: const ValueKey("Loaded"),
                children: [
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Container(
                          height: 70,
                          width: 70,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://cdn-icons-png.flaticon.com/512/12225/12225935.png",
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Shimmer.fromColors(
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  color: Colors.white,
                                ),
                                baseColor: isDark
                                    ? const Color(0xFF1E1E1E)
                                    : const Color(0xFFE0E0E0),
                                highlightColor: isDark
                                    ? const Color(0xFF3C3C3C)
                                    : const Color(0xFFF5F5F5),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(state.user.name, style: theme.headlineMedium),
                            Text(
                              state.user.email,
                              style: theme.bodyMedium!.copyWith(
                                color: const Color(0xff1E88E5),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  "assets/images/icons/coin.png",
                                  height: 18,
                                  width: 18,
                                ),
                                const SizedBox(width: 5),
                                Text("255 Points", style: theme.bodySmall),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      PopChild(
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.remove(AppConstants.userToken);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 30),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xff2C2C2C)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Icon(Icons.logout_outlined, color: icColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  _lists(
                    title: "Order",
                    name: "Order History",
                    img: "assets/images/icons/order_ic.png",
                    theme: theme,
                    icColor: icColor,
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: OrderHistory(),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                  ),
                  _lists(
                    title: "Payment",
                    name: "Payment Methods",
                    img: "assets/images/icons/payment_ic.png",
                    theme: theme,
                    icColor: icColor,
                    onTap: () {},
                  ),
                  _lists(
                    title: "Shipping",
                    name: "Shipping Addresses",
                    img: "assets/images/icons/shipping_ic.png",
                    theme: theme,
                    icColor: icColor,
                    onTap: () {},
                  ),
                  _lists(
                    title: "Wishlist",
                    name: "Saved Items",
                    img: "assets/images/icons/like_ic.png",
                    theme: theme,
                    icColor: icColor,
                    onTap: () {},
                  ),
                  _lists(
                    title: "Setting",
                    name: "Account Setting",
                    img: "assets/images/icons/account-settings_ic.png",
                    theme: theme,
                    icColor: icColor,
                    onTap: () {},
                  ),
                  _lists(
                    title: "Setting",
                    name: "App Setting",
                    img: "assets/images/icons/app_settings.ic.png",
                    theme: theme,
                    icColor: icColor,
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: AppSettings(),
                        withNavBar: false,
                      );
                    },
                    isTitle: false,
                  ),
                  const SizedBox(height: 120),
                ],
              );
            }
            else if (state is UserLoadingState) {
              child = const Center(
                key: ValueKey("Loading"),
                child: CircularProgressIndicator(),
              );
            }
            else if (state is UserFailureState) {
              print("error called");
              child = Center(
                key: const ValueKey("Error"),
                child: Text(state.errorMessage),
              );
            }
            else {
              child = const SizedBox.shrink(); // fallback for unknown state
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
      ),
    );
  }

  Widget _lists({
    required String title,
    required String name,
    required String img,
    required TextTheme theme,
    required Color icColor,
    required VoidCallback onTap,
    bool isTitle = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isTitle
            ? Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  title,
                  style: theme.headlineMedium!.copyWith(fontSize: 20),
                ),
              )
            : Container(),
        isTitle ? SizedBox(height: 8) : Container(),
        ListTile(
          onTap: onTap,
          leading: Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(img, color: icColor, width: 30, height: 30),
            ),
          ),
          title: Text(name, style: theme.bodyLarge),
          trailing: Icon(Icons.arrow_forward),
        ),
        isTitle ? SizedBox(height: 16) : Container(),
      ],
    );
  }
}
