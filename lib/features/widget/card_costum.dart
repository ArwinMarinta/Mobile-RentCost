import 'package:flutter/material.dart';
import 'package:RentCost/features/model/costum.dart';
import 'package:icons_plus/icons_plus.dart';

class CardCostum extends StatelessWidget {
  final List<Costum> costum;

  const CardCostum({required this.costum, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 285.0, // Atur tinggi dari widget
      child: ListView(
        scrollDirection: Axis.horizontal, // Scroll ke samping
        children: costum.map((data) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: 150.0, // Tentukan lebar setiap item
              decoration: BoxDecoration(
                  color:
                      Colors.white, // Ubah sesuai kebutuhan (misal background)
                  border: Border.all(color: Colors.black45, width: 0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3), // Warna bayangan
                      spreadRadius: 0.5, // Seberapa jauh shadow menyebar
                      blurRadius: 1, // Seberapa kabur bayangan
                      offset: const Offset(1, 2), // Posisi bayangan (x, y)))
                    )
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Menampilkan gambar dari data.path

                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6.0),
                        topRight: Radius.circular(6.0)),
                    // Radius untuk sudut membulat
                    child: Image.asset(
                      data.path,
                      fit: BoxFit.cover,
                      width: double
                          .infinity, // Agar gambar memenuhi lebar container
                      // height: 150.0, // Atur tinggi gambar sesuai kebutuhan
                    ),
                  ),

                  const SizedBox(height: 10.0),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 5.0),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.name,
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                          overflow: TextOverflow
                              .ellipsis, // Menambahkan titik-titik di akhir teks
                          maxLines: 1, // Membatasi menjadi satu baris
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          "Rp. ${data.price} / Hari",
                          style: const TextStyle(
                              fontSize: 14.0,
                              color: Color(0xFF881FFF),
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            const Icon(
                              Bootstrap.geo_alt,
                              size: 13.0,
                            ),
                            const SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              data.city,
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            const Icon(
                              Bootstrap.star_fill,
                              size: 13.0,
                              color: Color(0xFFF8B84E),
                            ),
                            const SizedBox(
                              width: 4.0,
                            ),
                            Text("${data.rating} | ${data.tersewa}")
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
