import 'package:flutter/material.dart';
import 'package:RentCost/features/model/costum.dart';

class CardCostum extends StatelessWidget {
  final List<Costum> costum;

  const CardCostum({required this.costum, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.0, // Atur tinggi dari widget
      child: ListView(
        scrollDirection: Axis.horizontal, // Scroll ke samping
        children: costum.map((data) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: 130.0, // Tentukan lebar setiap item
              decoration: BoxDecoration(
                  color:
                      Colors.white, // Ubah sesuai kebutuhan (misal background)
                  border: Border.all(color: Colors.black45, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Menampilkan gambar dari data.path

                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0)),
                    // Radius untuk sudut membulat
                    child: Image.asset(
                      data.path,
                      fit: BoxFit.cover,
                      width: double
                          .infinity, // Agar gambar memenuhi lebar container
                      // height: 150.0, // Atur tinggi gambar sesuai kebutuhan
                    ),
                  ),

                  // Image.asset(
                  //   data.path,
                  //   fit: BoxFit.cover,
                  // ),
                  const SizedBox(height: 10.0),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data.name),
                        Row(
                          children: [
                            const Text("Rp"),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(data.price),
                            const SizedBox(
                              width: 4.0,
                            ),
                            const Text("/ Hari")
                          ],
                        ),
                        Text(data.city),
                        Row(
                          children: [Text(data.rating), Text(data.tersewa)],
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
