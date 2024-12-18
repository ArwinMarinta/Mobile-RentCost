import 'package:flutter/material.dart';
import 'package:rentcost/features/model/costum.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';

class CardCostumTenant extends StatelessWidget {
  final Costum costum;

  const CardCostumTenant({required this.costum, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.0,
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
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          context.go('/detail');
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6.0),
                topRight: Radius.circular(6.0),
              ),
              child: Image.asset(
                costum.path,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 150,
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    costum.name,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    "Rp. ${costum.price} / Hari",
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Color(0xFF881FFF),
                      fontWeight: FontWeight.w600,
                    ),
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
                        costum.city,
                        style: const TextStyle(fontSize: 14.0),
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
                      Text("${costum.rating} | ${costum.tersewa}"),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  // Container(
                  //   width: double.infinity,
                  //   padding: const EdgeInsets.symmetric(vertical: 4.0),
                  //   decoration: BoxDecoration(
                  //     border: Border(
                  //       top: BorderSide(color: Colors.black, width: 0.5),
                  //     ),
                  //   ),
                  //   child: Text(
                  //     'Tersedia',
                  //     textAlign: TextAlign.center,
                  //     style: const TextStyle(fontSize: 16.0),
                  //   ),
                  // ),
                  Container(
                    // width: double.infinity,
                    // padding: const EdgeInsets.symmetric(vertical: 4.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0)
                        // border: Border(
                        //   top: BorderSide(color: Colors.black, width: 0.5),
                        // ),
                        ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(6.0),
                              bottomLeft: Radius.circular(6.0),
                            ),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              decoration:
                                  BoxDecoration(color: Color(0xFFFFBE05)),
                              child: Text(
                                "Edit",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(6.0),
                              bottomRight: Radius.circular(6.0),
                            ),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              decoration:
                                  BoxDecoration(color: Color(0xFFFE8A8A)),
                              child: Text(
                                "Hapus",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
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
          ],
        ),
      ),
    );
  }
}
