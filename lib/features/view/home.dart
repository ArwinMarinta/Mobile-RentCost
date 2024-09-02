import "package:flutter/material.dart";
import 'package:RentCost/features/view/navigation_bar.dart';
import 'package:icons_plus/icons_plus.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("assets/profiles.png"),
                            fit: BoxFit.cover)),
                  ),
                  const SizedBox(width: 6.0),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, Cina",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Mari cari kostum sekarang...",
                        style: TextStyle(fontSize: 16),
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
      body: const Center(
        child: Row(
          children: [
            Row(
              children: [],
            ),
            Row(
              children: [Text("Kanan")],
            )
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(selectedIndex: 0),
    );
  }
}
