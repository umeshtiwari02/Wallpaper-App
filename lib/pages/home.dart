import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List wallpaperimage = [
    "assets/images/w1.jpg",
    "assets/images/w2.jpg",
    "assets/images/w3.jpeg",
    "assets/images/w4.jpeg",
    "assets/images/w5.jpeg"
  ];

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 60, left: 20, right: 20.0),
        child: Column(
          children: [
            Row(
              children: [
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(60),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset(
                        "assets/images/me.jpg",
                        height: 60,
                        width: 60,
                      )),
                ),
                const SizedBox(
                  width: 80.0,
                ),
                const Text(
                  "Wallify",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            CarouselSlider.builder(
              itemCount: wallpaperimage.length,
              itemBuilder: (context, index, realIndex) {
                final res = wallpaperimage[index];
                return buildImage(res, index);
              },
              options: CarouselOptions(
                autoPlay: true,
                height: MediaQuery.of(context).size.height / 1.5,
                viewportFraction: 1,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Center(child: buildIndicator()),
          ],
        ),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: wallpaperimage.length,
        effect: const SlideEffect(
            dotWidth: 15, dotHeight: 15, activeDotColor: Colors.blue),
      );

  Widget buildImage(String urlImage, int index) => Container(
        margin: const EdgeInsets.only(right: 10),
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.asset(
            urlImage,
            fit: BoxFit.cover,
          ),
        ),
      );
}
