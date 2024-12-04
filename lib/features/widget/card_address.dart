import 'package:flutter/material.dart';
import 'package:rentcost/features/address/model/address_model.dart';
import 'package:rentcost/features/model/address.dart';
import 'package:icons_plus/icons_plus.dart';

class CardAddress extends StatelessWidget {
  final List<AddressData> address;
  final Function(int, bool?) onCheckboxChanged;
  final Function(int) onDelete;

  const CardAddress({
    required this.address,
    required this.onCheckboxChanged,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: address.length,
      itemBuilder: (context, index) {
        final data = address[index];
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black, width: 0.5)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Checkbox(
              //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              //   splashRadius: 0,
              //   fillColor: MaterialStateProperty.all(const Color(0xFF881FFF)),
              //   shape: const CircleBorder(),
              //   value: data.isSelected,
              //   onChanged: (bool? newValue) {
              //     onCheckboxChanged(index, newValue);
              //   },
              // ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address.first.username,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(address.first.address1),
                    if (data.address2.isNotEmpty) Text(address.first.address2),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => onDelete(index),
                child: const Icon(
                  Bootstrap.trash3,
                  size: 20,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
