import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:RentCost/features/model/detail.dart';

class DetailCostum extends StatefulWidget {
  const DetailCostum({super.key});

  @override
  State<DetailCostum> createState() => _DetailCostumState();
}

class _DetailCostumState extends State<DetailCostum> {
  final detail = Detail(
    image: "assets/costum1.png",
    name: "Raiden Shogoun Ba'al",
    rating: "4.5",
    tersewa: "32836",
    category: "Genshin Impact",
    price: "\$20.00",
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              context.go("/");
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
                "Detail",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                // Radius untuk sudut membulat
                child: Image.asset(
                  detail.image,
                  fit: BoxFit.cover,
                  width:
                      double.infinity, // Agar gambar memenuhi lebar container
                  // height: 150.0, // Atur tinggi gambar sesuai kebutuhan
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(detail.category),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 0.5),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          children: [
                            Text(detail.rating),
                            const SizedBox(
                              width: 6.0,
                            ),
                            const Icon(
                              Bootstrap.star_fill,
                              size: 13.0,
                              color: Color(0xFFF8B84E),
                            ),
                            const SizedBox(
                              width: 6.0,
                            ),
                            const Text('|'),
                            const SizedBox(
                              width: 6.0,
                            ),
                            Text(detail.tersewa)
                          ],
                        ),
                      )
                    ],
                  ),
                  Text(
                    detail.name,
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              const SizedBox(
                height: 12.0,
              ),
              Text(
                detail.price,
                style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF881FFF)),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Size",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: null,
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0xFFE8E8E8), width: 2.0),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Text(
                                "S",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: null,
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: const Color(0xFF881FFF), width: 2.0),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Text(
                                "M",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF881FFF)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: null,
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0xFFE8E8E8), width: 2.0),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Text(
                                "L",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // Warna shadow
                      offset: const Offset(0, -1), // Menggeser shadow ke atas
                      blurRadius: 1, // Jarak blur shadow
                      spreadRadius: 1, // Jarak spread shadow
                    ),
                  ],
                  border: const Border(

                      // top: BorderSide(width: 0.3, color: Colors.black),
                      bottom: BorderSide(width: 0.5, color: Colors.black))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        context.go('/cart');
                      });
                    },
                    child: const Icon(Bootstrap.cart),
                  ),
                  const SizedBox(
                    width: 60.0,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: null,
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFC67C4F),
                            border: Border.all(color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Text(
                            "Add to cart",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold), // Pusatkan teks
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
