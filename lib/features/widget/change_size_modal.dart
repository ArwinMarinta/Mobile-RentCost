import 'package:flutter/cupertino.dart';

class ChangeSizeModal extends StatelessWidget {
  const ChangeSizeModal({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Center(child: Text("Pilih Ukuran")),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("S"),
          Text("M"),
          Text("L"),
          Text("XL"),
          Text("XXL"),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.of(context).pop(); // Untuk menutup modal
          },
          child: const Text("Batalkan"),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.of(context).pop(); // Untuk menutup modal
          },
          child: const Text("Selesai"),
        ),
      ],
    );
  }
}
