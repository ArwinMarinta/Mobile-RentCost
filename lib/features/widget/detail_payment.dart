import 'package:flutter/material.dart';

class DetailPayment extends StatefulWidget {
  // final History history;

  const DetailPayment({super.key});

  @override
  State<DetailPayment> createState() => _DetailPaymentState();
}

class _DetailPaymentState extends State<DetailPayment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          // Container(
          //     width: double.infinity,
          //     decoration: BoxDecoration(
          //         border: Border(
          //             bottom: BorderSide(color: Colors.black, width: 0.5))),
          //     padding:
          //         const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          //     child: Text('Nomor Pesanan: 63823683')),
          // Container(
          //     decoration: BoxDecoration(
          //         border: Border(
          //             bottom: BorderSide(color: Colors.black, width: 0.5))),
          //     padding:
          //         const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          //     child: Row(
          //       children: [
          //         Icon(
          //           FontAwesome.truck_fast_solid,
          //           color: Color(0xFF0FB7FF),
          //         ),
          //         const SizedBox(
          //           width: 16.0,
          //         ),
          //         Text(
          //           "Dalam Pengiriman",
          //           style: TextStyle(fontSize: 16.0, color: Color(0xFF0FB7FF)),
          //         )
          //       ],
          //     )),
          Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.black, width: 0.5))),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Detail Pengiriman",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Text(
                      'Arwin Marinta \nJl. Sei Wein No.6 RT.34, Karang Joang, 3G kos Lantai 2 Nomor 21, Balikpapan, 0887655212766')
                ],
              )),
          Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.black, width: 0.5))),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6.0),
                          // Radius untuk sudut membulat
                          child: Image.asset(
                            'assets/costum1.png',
                            fit: BoxFit.cover,
                            width: 100.0,
                            height: 100.0,
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Genshin Impact"),
                            Text('Raiden Shogun Baal'),
                            Text('Size: M'),
                            Text('Rp. 400.000'),
                          ],
                        ))
                      ],
                    ),
                  )
                ],
              )),
          // Container(
          //     width: double.infinity,
          //     decoration: BoxDecoration(
          //         border: Border(
          //             bottom: BorderSide(color: Colors.black, width: 0.5))),
          //     padding:
          //         const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           "Metode Pembayaran",
          //           style:
          //               TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          //         ),
          //         const SizedBox(
          //           height: 8.0,
          //         ),
          //         Text(
          //           "Transfer Bank - BNI 907398235",
          //           style: TextStyle(fontSize: 16.0),
          //         )
          //       ],
          //     )),
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.black, width: 0.5))),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Pesanan",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "Rp 400.000",
                    style: TextStyle(fontSize: 16.0),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
