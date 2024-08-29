import 'package:RentCost/features/view/navigation_bar.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Header"),
      ),
      body: const Center(
        child: Text("Profile"),
      ),
      bottomNavigationBar: const CustomNavigationBar(selectedIndex: 3),
    );
  }
}
