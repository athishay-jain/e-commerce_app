import 'package:ecommerce_app/Screens/cart_screen.dart';
import 'package:ecommerce_app/Screens/home_screen.dart';
import 'package:ecommerce_app/Screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class DashboardScreen extends StatefulWidget{
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      CartScreen(),
      ProfileScreen(),
    ];
  }
int page =0;

  final PersistentTabController _controller = PersistentTabController(
    initialIndex: 0,
  );

  List<PersistentBottomNavBarItem> _navBarsItems(bool isDark) {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(
          CupertinoIcons.home,
        ),
        activeColorSecondary: Colors.white,
        title: ("Home"),
        textStyle: TextStyle(fontWeight: FontWeight.w600,fontFamily:"pop",),
        activeColorPrimary: Color(0xFF1E88E5),
        inactiveColorPrimary: Color(0xFF1E88E5),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          CupertinoIcons.cart,
        ),
        title: ("Cart"),
        textStyle: TextStyle(fontWeight: FontWeight.w600,fontFamily:"pop",),
        activeColorPrimary: Color(0xFF1E88E5),
        activeColorSecondary: Colors.white,
        inactiveColorPrimary: Color(0xFF1E88E5),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          CupertinoIcons.profile_circled,
        ),
        title: ("Profile"),
        textStyle: TextStyle(fontWeight: FontWeight.w600,fontFamily:"pop",),
        activeColorPrimary:Color(0xFF1E88E5),
        activeColorSecondary: Colors.white,
        inactiveColorPrimary: Color(0xFF1E88E5),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    // TODO: implement build
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(isDark),
onItemSelected: (index){
        page =index;
        print("the index is$index");
        print("the page is $page");
        setState(() {

        });
},
      handleAndroidBackButtonPress: true,
      // Default is true.
      margin: EdgeInsets.only(bottom: 40, left: 10, right: 10),
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(20),
        useBackdropFilter: true,
        border: Border.all(color: Colors.grey.withAlpha(50), width: 1.5),
      ),
      resizeToAvoidBottomInset: true,
      // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
      stateManagement: true,
      // Default is true.
      hideNavigationBarWhenKeyboardAppears: true,
      backgroundColor:page ==0? Colors.transparent:isDark?Color(0xff1E1E1E): Colors.white,
      isVisible: true,
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          screenTransitionAnimationType: ScreenTransitionAnimationType.slide,
        ),
      ),
      confineToSafeArea: true,
      navBarHeight: 80,
      navBarStyle:
      NavBarStyle.style7, // Choose the nav bar style with this property
    );
  }
}