import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/Screens/home_screen.dart';
import 'package:ecommerce_app/Screens/main_page.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatefulWidget {
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  CarouselSliderController _carouselController = CarouselSliderController();
  String swipeDirection = 'Swipe in any direction';

  void _handleSwipe(DragUpdateDetails details) {
    if(details.delta.dx<0) {
      if(_currentPage<2) {
        _carouselController.animateToPage(_currentPage + 1);
        setState(() {

        });
      }
    }
    if(details.delta.dx>0){
      if(_currentPage>0) {
        _carouselController.animateToPage(_currentPage - 1);
        setState(() {

        });
      }
    }
  }

  int _currentPage = 0;
  List<Map<String, dynamic>> _data = [
    {
      "title": "Discover Top Products",
      "image": "assets/images/onBoarding/gif_1.gif",
      "sub":
          "Find the latest electronics, fashion, appliances and more — all in one place",
    },
    {
      "title": "Safe & Easy Payments",
      "image": "assets/images/onBoarding/img_2.png",
      "sub":
          "Multiple payment options with secure checkout and fast delivery tracking",
    },
    {
      "title": "Get Exclusive Deals",
      "image": "assets/images/onBoarding/gif_3.gif",
      "sub":
          "Enjoy special discounts, deals, and personalized recommendations.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.blue.shade100,
          Colors.white
        ],begin: Alignment.topCenter,end: Alignment.bottomCenter)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            SizedBox(height: 100),
            CarouselSlider.builder(
              carouselController: _carouselController,
              itemCount: _data.length,
              itemBuilder: (context, index, realIndex) {
                return SizedBox(
                  height: 320,
                  width: 320,
                  child: Image.asset(_data[index]["image"], fit: BoxFit.cover),
                );
              },
              options: CarouselOptions(
                height: 290,
                aspectRatio: 1 / 1,
                autoPlay: _currentPage == 2 ? false : true,
                autoPlayInterval: Duration(seconds: 3),
                enlargeCenterPage: false,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  _currentPage = index;
                  setState(() {});
                },
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onPanUpdate: _handleSwipe,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  _data[_currentPage]["title"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: "pop",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onPanUpdate: _handleSwipe,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Text(
                  _data[_currentPage]["sub"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: "pop",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            _currentPage == 2
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage(),));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: Size(150, 60),
                      padding: EdgeInsets.symmetric(horizontal: 50),
                    ),
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                        fontFamily: "pop",
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _data.asMap().entries.map((entry) {
                      int index = entry.key;
                      return GestureDetector(
                        onTap: () => _carouselController.animateToPage(index),
                        child: Container(
                          width: _currentPage == index ? 12 : 12,
                          height: 12,
                          margin: EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 4.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: _currentPage == index
                                ? Colors.blue
                                : Colors.blue.shade100,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }
}
