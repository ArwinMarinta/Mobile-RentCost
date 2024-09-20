import 'package:RentCost/features/view/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2)),
              Text(
                "KERANJANG",
                style: TextStyle(
                    fontSize: 18.0,
                    // color: Color(0xFF881FFF),
                    fontWeight: FontWeight.w500),
              ),
            ],
          )),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: Colors
                        .white, // Ubah sesuai kebutuhan (misal background)
                    border: Border.all(color: Colors.black45, width: 0.2),
                    borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3), // Warna bayangan
                        spreadRadius: 0.5, // Seberapa jauh shadow menyebar
                        blurRadius: 1, // Seberapa kabur bayangan
                        offset: const Offset(1, 2), // Posisi bayangan (x, y)))
                      )
                    ]),
                child: Row(
                  children: [
                    const Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Bootstrap.geo_alt,
                            size: 25.0,
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Arwin Marinta",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Jl. Sei wein No.6 RT.34, karang joang, 3G kos lantai 2 nomor 21, 76127, Balikpapan Utara, Balikpapan (Kota), Kalimantan Timur",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6.0),
                    TextButton(
                      onPressed: () {},
                      child: const Text("Ubah"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(selectedIndex: 2),
    );
  }
}
