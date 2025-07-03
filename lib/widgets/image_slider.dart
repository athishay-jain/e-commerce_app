import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget{
  List<String>banners;
  ImageSlider({required this.banners});

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _currentBanner = 0;
  final CarouselController _carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 330,
      child: Column(
        mainAxisSize:MainAxisSize.min,
        children: [
          Expanded(
            child: CarouselSlider.builder(
              itemCount: widget.banners.length,
              itemBuilder: (context, index, realIdx) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
            
                    image: DecorationImage(
                      image: NetworkImage(widget.banners[index]),
            
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height:double.infinity,
                aspectRatio: 1 / 1,
                autoPlay: true,
                viewportFraction: 1,
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentBanner = index;
                  });
                },
              ),
            ),
          ),

          // Dots (below Carousel)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.banners.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _carouselController.animateToItem(entry.key),
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
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}