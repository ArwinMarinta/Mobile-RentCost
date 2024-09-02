import 'package:RentCost/features/view/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(child: Text("Akun Saya")),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Aktivitas",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(FontAwesome.user),
                          SizedBox(width: 6.0),
                          Text(
                            "Profile",
                            style: TextStyle(fontSize: 18.0),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(6.0))),
                  child: const Center(
                      child: Text(
                    "Keluar",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
                  ))),
              const Center(child: Text("Versi 0.0.1"))
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(selectedIndex: 3),
    );
  }
}
