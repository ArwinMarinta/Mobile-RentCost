import "package:rentcost/features/view/navigation_bar.dart";
import "package:flutter/material.dart";

class Shopping extends StatefulWidget {
  const Shopping({super.key});

  @override
  State<Shopping> createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        title: const Text("Header"),
      ),
      body: const Center(
        child: Text("Shop"),
      ),
      bottomNavigationBar: const CustomNavigationBar(selectedIndex: 2),
    );
  }
}
