import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/widgets/like_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
    {"image": "assets/images/categories/frg.png", "name": "fridge"},
    {"image": "assets/images/categories/phone.png", "name": "Phone"},
    {"image": "assets/images/categories/tv.png", "name": "Tv"},
    {"image": "assets/images/categories/lap.png", "name": "Laptop"},
    {"image": "assets/images/categories/ac.png", "name": "Ac"},
    {"image": "assets/images/categories/wash.png", "name": "Washing Machine"},
  ];
  List<Map<String, dynamic>> products = [
    {
      "image":
          "https://content.jdmagicbox.com/quickquotes/images_main/atomberg-renesa-smart-bldc-iot-ceiling-fan-golden-oakwood-natural-oakwood-2220048496-fsjnlr3r.jpg?impolicy=queryparam&im=Resize=(360,360),aspect=fit",
      "Name": "UltraCool Smart Fan",
      "price": "2,499",
      "mrp": "3,299",
      "off": 20,
    },
    {
      "image":
          "https://brain-images-ssl.cdn.dixons.com/5/2/10257225/l_10257225.jpg",
      "Name": "TurboMax Washing Machine",
      "price": "14,990",
      "mrp": "17,500",
      "off": "65",
    },
    {
      "image":
          "https://media-ik.croma.com/prod/https://media.croma.com/image/upload/v1729510459/Croma%20Assets/Entertainment/Television/Images/273733_0_w8e4qb.png",
      "Name": "Chroma LED TV 43",
      "price": "23,900",
      "mrp": "23,900",
      "off": "42",
    },
    {
      "image":
          "https://www.simplyshopping.in/cdn/shop/products/716YmAfmCoL._SL1500_1200x1200.jpg?v=1676113454",
      "Name": "SoundPro Bluetooth Speaker",
      "price": "1,599",
      "mrp": "2,199",
      "off": "17",
    },
    {
      "image":
          "https://electronicparadise.in/cdn/shop/files/Voltas_1.0_Ton_3_Star_Split_Air_Conditioner_123_Vectra_Elegant_1.webp?v=1739427287&width=640",
      "Name": "CoolMist Air Conditioner",
      "price": "38,500",
      "mrp": "43,000",
      "off": "35",
    },
    {
      "image":
          "https://i5.walmartimages.com/asr/e3809b88-267e-4f13-bbb1-16e7cc98ee1b.75f3a22226dfbb1058c67906c0eaf942.jpeg",
      "Name": "InstaBrew Coffee Maker",
      "price": "3,750",
      "mrp": "4,499",
      "off": "50",
    },
  ];
  int _currentBanner = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFe3f2fd), Color(0xFFbbdefb)],
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20, top: 16),
                child: Text(
                  "Hello,Athishay👋",
                  style: TextStyle(
                    fontSize: 31,
                    fontWeight: FontWeight.w600,
                    fontFamily: "pop",
                    color: Color(0xff212121),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: "pop",
                    color: Color(0xff757575),
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withAlpha(140),
                    prefixIcon: Icon(
                      CupertinoIcons.search,
                      color: Color(0xff757575),
                    ),
                    suffixIcon: Icon(
                      CupertinoIcons.camera_viewfinder,
                      color: Color(0xff757575),
                      size: 30,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    hintText: "Search",
                    hintStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: "pop",
                      color: Color(0xff616161),
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
                          color: Colors.black.withOpacity(0.1),
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
                children: banners.asMap().entries.map((entry) {
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
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Categories",
                      style: TextStyle(
                        color: Color(0xff212121),
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        fontFamily: "pop",
                      ),
                    ),
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
              SizedBox(
                height: 150,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: categoriesItems.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(
                              categoriesItems[index]["image"],
                            ),
                          ),
                          SizedBox(height: 6),
                          SizedBox(
                            width: 80,
                            child: Text(
                              categoriesItems[index]['name'],
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "pop",
                                fontWeight: FontWeight.w500,
                              ),
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "For you",
                      style: TextStyle(
                        color: Color(0xff212121),
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        fontFamily: "pop",
                      ),
                    ),
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
              GridView.builder(
                padding: EdgeInsets.only(top: 10, left: 20,right: 20,bottom: 110),
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
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      //color: Color(0xffF5F5F5),
                      color: Colors.white,
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 10,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 10),
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: Image.network(
                                  products[index]["image"],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                width: 160,
                                child: Text(
                                  products[index]["Name"],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "pop",
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "₹${products[index]["price"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "pop",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "M.R.P:",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "pop",
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    "₹${products[index]["mrp"]}",

                                    style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 14,
                                      fontFamily: "pop",
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 5,
                          left: 10,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red,
                            ),
                            child: Text(
                              "${products[index]["off"]}%off",
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
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
