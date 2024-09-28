import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  TextEditingController userName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController province = TextEditingController();
  TextEditingController zipCode = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();

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
              context.go("/select_address");
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
                "Tambah Alamat",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: userName,
                onChanged: null,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: InputBorder.none, // Menghapus border default
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF8E8E8E),
                        width: 1.0), // Warna border saat tidak fokus
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF881FFF),
                        width: 2.0), // Warna border saat fokus
                  ),
                ),
              ),
              TextField(
                controller: phoneNumber,
                onChanged: null,
                decoration: const InputDecoration(
                  labelText: 'Nomor Telepon',
                  border: InputBorder.none, // Menghapus border default
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF8E8E8E),
                        width: 1.0), // Warna border saat tidak fokus
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF881FFF),
                        width: 2.0), // Warna border saat fokus
                  ),
                ),
              ),
              TextField(
                controller: province,
                onChanged: null,
                decoration: const InputDecoration(
                  labelText: 'Provinsi',
                  border: InputBorder.none, // Menghapus border default
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF8E8E8E),
                        width: 1.0), // Warna border saat tidak fokus
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF881FFF),
                        width: 2.0), // Warna border saat fokus
                  ),
                ),
              ),
              TextField(
                controller: city,
                onChanged: null,
                decoration: const InputDecoration(
                  labelText: 'Kota',
                  border: InputBorder.none, // Menghapus border default
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF8E8E8E),
                        width: 1.0), // Warna border saat tidak fokus
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF881FFF),
                        width: 2.0), // Warna border saat fokus
                  ),
                ),
              ),
              TextField(
                controller: zipCode,
                onChanged: null,
                decoration: const InputDecoration(
                  labelText: 'Kode Pos',
                  border: InputBorder.none, // Menghapus border default
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF8E8E8E),
                        width: 1.0), // Warna border saat tidak fokus
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF881FFF),
                        width: 2.0), // Warna border saat fokus
                  ),
                ),
              ),
              TextField(
                controller: address1,
                onChanged: null,
                decoration: const InputDecoration(
                  labelText: 'Nama Jalan, Gedung, No. Rumah',
                  border: InputBorder.none, // Menghapus border default
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF8E8E8E),
                        width: 1.0), // Warna border saat tidak fokus
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF881FFF),
                        width: 2.0), // Warna border saat fokus
                  ),
                ),
              ),
              TextField(
                controller: address2,
                onChanged: null,
                decoration: const InputDecoration(
                  labelText: 'Detail Lainnya',
                  border: InputBorder.none, // Menghapus border default
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF8E8E8E),
                        width: 1.0), // Warna border saat tidak fokus
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF881FFF),
                        width: 2.0), // Warna border saat fokus
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: SizedBox(
          // padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GestureDetector(
            onTap: null,
            child: Container(
              decoration: const BoxDecoration(
                  color: Color(0xFF881FFF),
                  borderRadius: BorderRadius.all(Radius.circular(6.0))),
              // padding: const EdgeInsets.all(16.0),
              child: const Center(
                child: Text(
                  'Tambah',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
