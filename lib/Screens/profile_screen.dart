import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/Screens/Profile_screens/app_settings.dart';
import 'package:ecommerce_app/widgets/pop_effect.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatelessWidget {
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
          title: Text("Profile"),
          backgroundColor: Colors.transparent,
        ),
        body: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Container(
                    height: 70,
                    width: 70,
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(60),
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
                              ? Color(0xFF1E1E1E)
                              : Color(0xFFE0E0E0),
                          highlightColor: isDark
                              ? Color(0xFF3C3C3C)
                              : Color(0xFFF5F5F5),
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
                      Text("Athishay Jain", style: theme.headlineMedium),
                      Text(
                        "aj@gmail.com",
                        style: theme.bodyMedium!.copyWith(
                          color: Color(0xff1E88E5),
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
                          SizedBox(width: 5,),
                          Text("255 Points", style: theme.bodySmall),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                PopChild(
                  child: Container(
                    margin: EdgeInsets.only(right: 30),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: isDark ? Color(0xff2C2C2C) : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Icon(Icons.logout_outlined, color: icColor),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            _lists(
              title: "Order",
              name: "Order History",
              img: "assets/images/icons/order_ic.png",
              theme: theme,
              icColor: icColor,
              onTap: () {},
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
            SizedBox(height: 120),
          ],
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
