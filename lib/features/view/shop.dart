import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
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
                "Toko Saya",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: Column(
            children: <Widget>[
              Container(
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Riwayat Rentalan",
                      style: TextStyle(
                          // color: const Color(0xFF881FFF),
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesome.box_solid,
                              size: 50,
                              color: Color(0xFF881FFF),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Pesanan \nBaru",
                              style: TextStyle(fontSize: 16.0),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Icon(
                              // Bootstrap.box_seam,
                              FontAwesome.box_archive_solid,
                              size: 50,
                              color: Color(0xFF881FFF),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Siap \n Kirim",
                              style: TextStyle(fontSize: 16.0),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Icon(
                              FontAwesome.truck_fast_solid,
                              size: 50,
                              color: Color(0xFF881FFF),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Sedang \n Dikirim",
                              style: TextStyle(fontSize: 16.0),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Icon(
                              FontAwesome.box_open_solid,
                              size: 50,
                              color: Color(0xFF881FFF),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Pesanan \nBaru",
                              style: TextStyle(fontSize: 16.0),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              // GestureDetector(
              //   onTap: null,
              //   child: Container(
              //     child: Text("Komplain sebagai penjual"),
              //   ),
              // )
              const SizedBox(
                height: 30.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Produk",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  DottedBorder(
                    strokeWidth: 1,
                    padding: const EdgeInsets.all(10.0),
                    color: const Color(0xFF881FFF),
                    dashPattern: const [5, 5],
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: null,
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4.0)),
                                  border: Border.all(
                                      color: const Color(0xFFBEBEBE),
                                      width: 0.8)),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 6.0),
                              child: const Center(
                                  child: Text(
                                "Tambahkan Produk",
                                style: TextStyle(
                                    color: Color(0xFF881FFF),
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500),
                              ))),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        GestureDetector(
                          onTap: null,
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4.0)),
                                  border: Border.all(
                                      color: const Color(0xFFBEBEBE),
                                      width: 0.8)),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 6.0),
                              child: const Center(
                                  child: Text(
                                "Atur Denda Produk",
                                style: TextStyle(
                                    color: Color(0xFF881FFF),
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500),
                              ))),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: null,
                          child: Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black, // Warna border
                                  width: 0.3, // Ketebalan border
                                ),
                              )),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 6.0),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Kostum Anda",
                                        style: TextStyle(
                                            // color: Color(0xFF881FFF),
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 2.0,
                                      ),
                                      Text(
                                        "Lihat dan atur semua produk",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                            // color: Color(0xFF881FFF),
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w300),
                                      )
                                    ],
                                  ),
                                  Icon(
                                    Bootstrap.caret_right_fill,
                                    color: Color(0xFFBEBEBE),
                                  )
                                ],
                              )),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        GestureDetector(
                          onTap: null,
                          child: Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black, // Warna border
                                  width: 0.3, // Ketebalan border
                                ),
                              )),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 6.0),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Denda Rental",
                                          style: TextStyle(
                                              // color: Color(0xFF881FFF),
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 2.0,
                                        ),
                                        Text(
                                          "Lihat denda yang dikenakan untuk pembeli",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              // color: Color(0xFF881FFF),
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w300),
                                        )
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Bootstrap.caret_right_fill,
                                    color: Color(0xFFBEBEBE),
                                  )
                                ],
                              )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
