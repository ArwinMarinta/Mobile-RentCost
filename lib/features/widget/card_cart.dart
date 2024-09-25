import 'package:flutter/material.dart';
import 'package:RentCost/features/model/cart.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:RentCost/features/widget/change_size_modal.dart';

class CardCart extends StatefulWidget {
  final List<CartType> cart;

  const CardCart({required this.cart, super.key});

  @override
  State<CardCart> createState() => _CardCartState();
}

class _CardCartState extends State<CardCart> {
  bool? value = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.cart.map((data) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            border:
                Border.all(color: Colors.grey, width: 0.2), // Memberi border
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  child: Row(
                    children: [
                      Checkbox(
                        side: const BorderSide(width: 0.6),
                        value: value,
                        // key: data.id,
                        onChanged: (bool? newValue) {
                          setState(() {
                            value = newValue;
                          });
                        },
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          data.image,
                          width: 80.0,
                          height: 80.0,
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return const Icon(Icons
                                .error); // Atau widget lain untuk menampilkan error
                          },
                        ),
                      ),
                      const SizedBox(width: 20), // Jarak antar gambar dan teks
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.name,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(data.category),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              const Text("Ukuran: "),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const ChangeSizeModal();
                                    },
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 0.2),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4.0))),
                                  child: Row(
                                    children: [
                                      Text(
                                        data.size,
                                        style: const TextStyle(
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8.0,
                                      ),
                                      const Icon(
                                        Bootstrap.chevron_down,
                                        size: 15.0,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Rp. ${data.price}",
                            style: const TextStyle(
                                fontSize: 16.0,
                                color: Color(0xFF881FFF),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 12.0,
                ),
                child: GestureDetector(
                  onTap: null,
                  child: const Icon(
                    Bootstrap.x,
                    size: 30,
                  ),
                ),
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
