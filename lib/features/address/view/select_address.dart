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
    context.read<AddressBloc>().add(RequestAddress());
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
        if (state is AddressLoading) {
          return const Center(
            child: CircularProgressIndicator(),
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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.username,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(data.address1),
                                if (data.address2.isNotEmpty)
                                  Text(data.address2),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: null,
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
