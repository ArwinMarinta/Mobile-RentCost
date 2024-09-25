import 'package:flutter/material.dart';
import 'package:RentCost/features/model/cart.dart';
import 'package:RentCost/features/view/navigation_bar.dart';
import 'package:RentCost/features/widget/card_cart.dart';
import 'package:icons_plus/icons_plus.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final List<CartType> cart = cartList; // Assuming cartList is predefined
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
            Padding(padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2)),
            Text(
              "KERANJANG",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black45, width: 0.2),
                    borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 0.5,
                        blurRadius: 1,
                        offset: const Offset(1, 2),
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
                                  "Jl. Sei wein No.6 RT.34, karang joang...",
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
              ),
              const SizedBox(
                height: 20.0,
              ),
              CardCart(cart: cart),
            ],
          ),
        ),
      ),
      // floatingActionButton: Container(
      //   height:
      //       56, // Sesuaikan tinggi dengan ukuran FloatingActionButton default
      //   width: 56, // Sesuaikan lebar dengan ukuran FloatingActionButton default
      //   child: FloatingActionButton(
      //     onPressed: () {
      //       // Aksi untuk tombol
      //     },
      //     child: Text("Saman"),
      //   ),
      // ),
      bottomNavigationBar: const CustomNavigationBar(selectedIndex: 2),
    );
  }
}
