import 'package:RentCost/features/widget/card_history.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:RentCost/features/model/history.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({super.key});

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  final List<History> history = hustoryList;
  String selectStatus = 'Selesai';
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
            Padding(padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2)),
            Text(
              "Pesanan Saya",
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectStatus = "Selesai";
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        decoration: BoxDecoration(
                            border: selectStatus == "Selesai"
                                ? Border(
                                    bottom: BorderSide(
                                        color: Color(0xFF881FFF), width: 3.0))
                                : Border(
                                    bottom: BorderSide(
                                        color: Colors.white, width: 3.0))),
                        child: Center(
                          child: Text(
                            "Selesai",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectStatus = "Diproses";
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        decoration: BoxDecoration(
                            border: selectStatus == "Diproses"
                                ? Border(
                                    bottom: BorderSide(
                                        color: Color(0xFF881FFF), width: 3.0))
                                : Border(
                                    bottom: BorderSide(
                                        color: Colors.white, width: 3.0))),
                        child: Text(
                          "Diproses",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectStatus = "Dikirim";
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        decoration: BoxDecoration(
                            border: selectStatus == "Dikirim"
                                ? Border(
                                    bottom: BorderSide(
                                        color: Color(0xFF881FFF), width: 3.0))
                                : Border(
                                    bottom: BorderSide(
                                        color: Colors.white, width: 3.0))),
                        child: Text(
                          "Dikirim",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
      body: ListView.builder(
          itemCount: history.length,
          itemBuilder: (context, index) {
            return CardHistory(history: history[index]);
          }),
    );
  }
}
