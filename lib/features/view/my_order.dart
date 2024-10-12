import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({super.key});

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              context.go("/profile");
            },
            child: const Icon(
              FontAwesome.chevron_left_solid,
              color: Colors.black,
            ),
          ),
          elevation: 0,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2)),
              Text(
                "Pesanan Saya",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )),
    );
  }
}
