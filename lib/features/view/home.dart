import 'package:RentCost/features/widget/carousel_category.dart';
import "package:flutter/material.dart";
import 'package:RentCost/features/view/navigation_bar.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:RentCost/features/widget/carousel_banner.dart';
import 'package:RentCost/features/model/category.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    List<String> imagePaths =
        categoryList.map((category) => category.path).toList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 35.0,
                    height: 35.0,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xFF881FFF), width: 1.0),
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                            image: AssetImage("assets/profiles.png"),
                            fit: BoxFit.cover)),
                  ),
                  const SizedBox(width: 6.0),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hai, Cina",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Temukan kostum favoritmu...",
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  )
                ],
              ),
              const Row(
                children: [
                  Icon(FontAwesome.magnifying_glass_solid),
                  SizedBox(width: 10.0),
                  Icon(FontAwesome.bell)
                ],
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const CarouselBanner(
              imagePaths: [
                "assets/banner3.png",
                "assets/banner4.png",
                "assets/banner3.png",
                "assets/banner4.png"
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Kategori Cosplay",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF881FFF)),
                      ),
                      GestureDetector(
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Lihat Semua",
                              style: TextStyle(
                                  fontSize: 13.0, color: Color(0xFF881FFF)),
                            ),
                            Icon(
                              Bootstrap.chevron_right,
                              size: 11.0,
                              weight: 10.0,
                              color: Color(0xFF881FFF),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 18.0,
                  ),
                  CarouselCategory(imagePaths: imagePaths)
                ],
              ),
            ),
            // CarouselCategory(imagePaths: imagePaths)
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(selectedIndex: 0),
    );
  }
}
