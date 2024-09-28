import "package:RentCost/features/view/navigation_bar.dart";
import "package:flutter/material.dart";

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        title: const Text("Header"),
      ),
      body: const Center(
        child: Text("Categori"),
      ),
      bottomNavigationBar: const CustomNavigationBar(selectedIndex: 1),
    );
  }
}
