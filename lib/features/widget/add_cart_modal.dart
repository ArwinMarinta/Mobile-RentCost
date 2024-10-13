import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class AddCartModal extends StatefulWidget {
  const AddCartModal({super.key});

  @override
  State<AddCartModal> createState() => _AddCartModalState();
}

class _AddCartModalState extends State<AddCartModal> {
  bool? value = false; // Menyimpan status checkbox

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 300.0,
      width: double.infinity,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.black, width: 0.5))),
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Column(
                children: [
                  Icon(Bootstrap.chevron_down),
                  const SizedBox(height: 6.0),
                  Text(
                    "Pilih Ukuran",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      splashRadius: 0,
                      fillColor: WidgetStateProperty.resolveWith<Color?>(
                          (Set<WidgetState> states) {
                        if (states.contains(WidgetState.selected)) {
                          return const Color(
                              0xFF881FFF); // Warna saat dicentang
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
                    Text('S')
                  ],
                ),
                Text("1 Product")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      splashRadius: 0,
                      fillColor: WidgetStateProperty.resolveWith<Color?>(
                          (Set<WidgetState> states) {
                        if (states.contains(WidgetState.selected)) {
                          return const Color(
                              0xFF881FFF); // Warna saat dicentang
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
                    Text('M')
                  ],
                ),
                Text("1 Product")
              ],
            ),
            // ElevatedButton(
            //   child: const Text('Close BottomSheet'),
            //   onPressed: () => Navigator.pop(context), // Menutup modal
            // ),
          ],
        ),
      ),
    );
  }
}
