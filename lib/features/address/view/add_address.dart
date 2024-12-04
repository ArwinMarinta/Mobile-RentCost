import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:rentcost/features/address/bloc/address_bloc.dart';
import 'package:rentcost/features/address/bloc/address_event.dart';
import 'package:rentcost/features/address/bloc/address_state.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  TextEditingController userName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
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
          child: BlocListener<AddressBloc, AddressState>(
            listener: (context, state) {
              if (state is AddressLoading) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is AddressSuccess) {
                Navigator.of(context).pop();

                context.go('/select_address');
              } else if (state is AddressFailure) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Buat adreess: ${state.error}')),
                );
              }
            },
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
                  controller: state,
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
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: SizedBox(
          // padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GestureDetector(
            onTap: () {
              final userameText = userName.text.trim();
              final phoneNumberText = phoneNumber.text.trim();
              final cityText = city.text.trim();
              final zipCodeTExt = zipCode.text.trim();
              final stateText = state.text.trim();
              final address1Text = address1.text.trim();
              final address2Text = address2.text.trim();

              if (userameText.isNotEmpty &&
                  phoneNumberText.isNotEmpty &&
                  cityText.isNotEmpty &&
                  zipCodeTExt.isNotEmpty &&
                  stateText.isNotEmpty &&
                  address1Text.isNotEmpty &&
                  address2Text.isNotEmpty) {
                context.read<AddressBloc>().add(CreateAddress(
                    username: userameText,
                    phone_number: phoneNumberText,
                    city: cityText,
                    zip_code: zipCodeTExt,
                    state: stateText,
                    address1: address1Text,
                    address2: address2Text));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Field tidak boleh kosong'),
                  ),
                );
              }
            },
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
