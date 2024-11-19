import 'package:flutter/material.dart';
import 'package:rentcost/features/model/address.dart';
import 'package:icons_plus/icons_plus.dart';

class CardAddress extends StatefulWidget {
  final List<AddressType> address;

  const CardAddress({required this.address, super.key});

  @override
  State<CardAddress> createState() => _CardAddressState();
}

class _CardAddressState extends State<CardAddress> {
  bool? value = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.address.map((data) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.black, width: 0.5))),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                splashRadius: 0,
                fillColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return const Color(0xFF881FFF); // Warna saat dicentang
                  }
                  return Colors.white; // Warna saat tidak dicentang
                }),
                // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: const CircleBorder(),
                side: const BorderSide(width: 0.6),
                value: value,
                // key: data.id,
                onChanged: (bool? newValue) {
                  setState(() {
                    value = newValue;
                  });
                },
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data.fullName} | ${data.phoneNumber} ',
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      data.address1,
                      softWrap: true,
                      // overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      data.address2,
                      softWrap: true,
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Center(
                  child: GestureDetector(
                    onTap: null,
                    child: const Icon(
                      Bootstrap.trash3,
                      size: 20,
                      color: Colors.red,
                    ),
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
