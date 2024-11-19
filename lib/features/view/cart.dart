// import 'package:RentCost/features/view/home.dart';
import 'package:flutter/material.dart';
import 'package:rentcost/features/model/cart.dart';
import 'package:rentcost/features/view/navigation_bar.dart';
import 'package:rentcost/features/widget/card_cart.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool? value = false;
  @override
  Widget build(BuildContext context) {
    final List<CartType> cart = cartList; // Assuming cartList is predefined
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
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
                      onPressed: () {
                        setState(() {
                          context.go('/select_address');
                        });
                      },
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
      bottomNavigationBar: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Pastikan ukuran kolom minimal
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
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
                  Container(
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              splashRadius: 0,
                              fillColor:
                                  WidgetStateProperty.resolveWith<Color?>(
                                      (Set<WidgetState> states) {
                                if (states.contains(WidgetState.selected)) {
                                  return const Color(
                                      0xFF881FFF); // Warna saat dicentang
                                }
                                return Colors
                                    .white; // Warna saat tidak dicentang
                              }),
                              // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              // shape: const CircleBorder(),
                              side: const BorderSide(width: 0.6),
                              value: value,
                              // key: data.id,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  value = newValue;
                                });
                              },
                            ),
                            const Text("Semua")
                          ],
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        const Text("Rp. 400.000"),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.go('/payment');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: const BoxDecoration(
                          color: Color(0xFF881FFF),
                          borderRadius: BorderRadius.all(Radius.circular(6.0))),
                      child: const Text(
                        "Lanjut \n Pembayaran",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const CustomNavigationBar(selectedIndex: 2),
          ],
        ),
      ),
    );
  }
}
