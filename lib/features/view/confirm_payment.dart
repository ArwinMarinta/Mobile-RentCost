import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

class ConfirmPayment extends StatefulWidget {
  const ConfirmPayment({super.key});

  @override
  State<ConfirmPayment> createState() => _ConfirmPaymentState();
}

class _ConfirmPaymentState extends State<ConfirmPayment> {
  String? showFileName = "";
  String errorMessage = '';
  int maxSizeInBytes = 3 * 1024 * 1024;
  FilePickerResult? filePickerResult;
  final currentDate = DateTime.now();
  final currentEnd = DateTime.now().add(const Duration(days: 1));
  // String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              context.go("/profile");
            },
            child: const Icon(
              FontAwesome.chevron_left_solid,
              color: Colors.black,
            ),
          ),
          elevation: 0,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2)),
              Text(
                "Konfirmasi Pembayaran",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                child: Column(
                  children: [
                    Text(
                      "Nomor Order",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      onChanged: null,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Order Number',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF8E8E8E), width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(
                              color: Color(0xFF881FFF),
                              width: 2.0), // Mengatur border saat fokus
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const SizedBox(
                child: Column(
                  children: [
                    Text(
                      "Nama Rekening",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      onChanged: null,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Arwin Marinta',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF8E8E8E), width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(
                              color: Color(0xFF881FFF),
                              width: 2.0), // Mengatur border saat fokus
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const SizedBox(
                child: Column(
                  children: [
                    Text(
                      "Bank Asal",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      onChanged: null,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'BCA',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF8E8E8E), width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(
                              color: Color(0xFF881FFF),
                              width: 2.0), // Mengatur border saat fokus
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const SizedBox(
                child: Column(
                  children: [
                    Text(
                      "Bank Tujuan",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      onChanged: null,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'BNI',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF8E8E8E), width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(
                              color: Color(0xFF881FFF),
                              width: 2.0), // Mengatur border saat fokus
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const SizedBox(
                child: Column(
                  children: [
                    Text(
                      "Nominal Transfer",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      onChanged: null,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'ex: 30000',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF8E8E8E), width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(
                              color: Color(0xFF881FFF),
                              width: 2.0), // Mengatur border saat fokus
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                child: Column(
                  children: [
                    Text(
                      "Tanggal Transfer",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: TextField(
                          controller: TextEditingController(
                            text: _selectedDate != null
                                ? DateFormat('yyyy-MM-dd')
                                    .format(_selectedDate!)
                                : '',
                          ),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'Pilih Tanggal',
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 20.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF8E8E8E), width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                              borderSide: BorderSide(
                                color: Color(0xFF881FFF),
                                width: 2.0, // Mengatur border saat fokus
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Column(
                children: [
                  const Text(
                    "Bukti Transfer",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                            border: Border.all(color: Colors.black, width: 0.5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      filePickerResult =
                                          await FilePicker.platform.pickFiles(
                                        type: FileType.custom,
                                        allowedExtensions: [
                                          'jpeg',
                                          'jpg',
                                          'png'
                                        ],
                                      );

                                      if (filePickerResult != null) {
                                        var file =
                                            filePickerResult!.files.first;
                                        if (file.size > maxSizeInBytes) {
                                          setState(() {
                                            errorMessage =
                                                'Ukuran file tidak boleh lebih dari 1 MB';
                                            showFileName = '';
                                          });
                                        } else {
                                          // Jika ukuran file sesuai, perbarui state dengan nama file
                                          setState(() {
                                            showFileName = file.name;
                                            errorMessage =
                                                ''; // Clear any previous error message
                                          });
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14.0, horizontal: 8.0),
                                      backgroundColor: const Color(0xFF881FFF),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0)),
                                      ),
                                    ),
                                    child: const Text(
                                      'Pilih File',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        showFileName!,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 40.0,
              ),
              Container(
                width: double.infinity,
                child: GestureDetector(
                  onTap: null,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color(0xFF881FFF),
                        borderRadius: BorderRadius.all(Radius.circular(6.0))),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: const Center(
                        child: Text(
                      "Konfirmasi",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
