import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcost/features/address/bloc/address_bloc.dart';
import 'package:rentcost/features/address/bloc/address_event.dart';
import 'package:rentcost/features/address/bloc/address_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

class SelectAddress extends StatelessWidget {
  const SelectAddress({super.key});

  @override
  Widget build(BuildContext context) {
    bool? value;
    int? selectedAddressId;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            context.go("/cart");
          },
          child: const Icon(
            FontAwesome.chevron_left_solid,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        title: const Text(
          "Pilih Alamat",
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<AddressBloc, AddressState>(builder: (context, state) {
        if (state is AddressInitial) {
          context.read<AddressBloc>().add(RequestAddress());
        } else if (state is AddressLoading) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is AddressLoaded) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.address.length,
                  itemBuilder: (context, index) {
                    final data = state.address[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            splashRadius: 0,
                            fillColor: WidgetStateProperty.resolveWith<Color?>(
                              (Set<WidgetState> states) {
                                if (states.contains(WidgetState.selected)) {
                                  return const Color(
                                      0xFF881FFF); // Warna saat dicentang
                                }
                                return Colors
                                    .white; // Warna saat tidak dicentang
                              },
                            ),
                            shape: const CircleBorder(),
                            side: const BorderSide(width: 0.6),
                            value: data.used == true,
                            onChanged: (data.used == true)
                                ? (bool? newValue) {
                                    // Jika data.used == true, checkbox dapat diubah
                                    selectedAddressId = data
                                        .id; // Menyimpan ID alamat yang dipilih
                                  }
                                : (bool?
                                    newValue) {}, // Jika data.used != true, checkbox tidak bisa diubah// Nonaktifkan jika data.used tidak
                            // Nonaktifkan checkbox jika alamat tidak tersedia
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${data.username} | ${data.phoneNumber}',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '${data.address1} ${data.address2} ${data.city} ${data.state} ${data.zipCode}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: GestureDetector(
                              onTap: null,
                              child: Center(
                                child: const Icon(
                                  Bootstrap.trash3,
                                  size: 20,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                GestureDetector(
                  onTap: () {
                    context.go("/add_address");
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    width: double.infinity,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Bootstrap.plus_circle,
                          size: 20,
                          color: Color(0xFF881FFF),
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          "Tambah Alamat",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF881FFF),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is AddressFailure) {
          return Center(
            child: Text(state.error),
          );
        }
        return const Center(
          child: Text("Belum ada alamat tersimpan"),
        );
      }),
    );
  }
}
