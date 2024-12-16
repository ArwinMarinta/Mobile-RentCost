import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:rentcost/features/product/model/product.dart';

class CardCostumSearch extends StatelessWidget {
  final List<ProductData> costum;

  const CardCostumSearch({required this.costum, super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 6.0,
        mainAxisSpacing: 6.0,
        childAspectRatio: 0.62,
      ),
      itemCount: costum.length,
      itemBuilder: (context, index) {
        final data = costum[index];
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: GestureDetector(
            onTap: () {
              context.go('/detail/${data.id}');
            },
            child: Container(
              width: 150.0,
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
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Menampilkan gambar dari data.imageUrl
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6.0),
                      topRight: Radius.circular(6.0),
                    ),
                    child: Image.network(
                      data.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 150,
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
                          data.productName, // Menggunakan data.productName
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          "Rp. ${data.price} / 3 Hari", // Menggunakan data.price
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
                            const SizedBox(width: 4.0),
                            Text(
                              data.productName, // Menggunakan data.productName
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
                            const SizedBox(width: 4.0),
                            Text(
                                "${data.rate} | ${data.rentalAmount}x Tersewa"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
