import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcost/features/address/bloc/address_bloc.dart';
import 'package:rentcost/features/address/bloc/address_event.dart';
import 'package:rentcost/features/address/bloc/address_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:rentcost/features/cart/bloc/cart_bloc.dart';
import 'package:rentcost/features/cart/bloc/cart_event.dart';
import 'package:rentcost/features/model/address.dart';

class SelectAddress extends StatefulWidget {
  const SelectAddress({super.key});

  @override
  _SelectAddressState createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressBloc, AddressState>(
      listener: (context, state) {
        if (state is AddressDeleteLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is AddressDeleteSuccess) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(
                child: Text(
                  state.message,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            ),
          );
          context.read<AddressBloc>().add(RequestAddress());
          context.read<CartBloc>().add(CartRequest());
        } else if (state is AddressDeleteFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(
                child: Text(
                  state.error,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            ),
          );
        }
      },
      child: Scaffold(
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
        body: BlocBuilder<AddressBloc, AddressState>(
          builder: (context, state) {
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
                        bool isChecked =
                            data.used ?? false; // Local state for checkbox

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
                                child: Container(
                                  padding: const EdgeInsets.all(
                                      10), // Padding untuk area lebih luas
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        splashRadius: 0,
                                        fillColor: WidgetStateProperty
                                            .resolveWith<Color?>(
                                          (Set<WidgetState> states) {
                                            if (states.contains(
                                                WidgetState.selected)) {
                                              return const Color(0xFF881FFF);
                                            }
                                            return Colors.white;
                                          },
                                        ),
                                        shape: const CircleBorder(),
                                        side: const BorderSide(width: 0.6),
                                        value:
                                            isChecked, // Use local state here
                                        onChanged: (bool? newValue) {
                                          setState(() {
                                            isChecked = newValue ?? false;
                                          });
                                          if (newValue == true) {
                                            context.read<AddressBloc>().add(
                                                ShippingAddressUpdate(
                                                    id: data.id.toString()));
                                          }
                                        },
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    if (data.id != 0) {
                                      context.read<AddressBloc>().add(
                                          AddressDeleteRequest(
                                              id: data.id.toString()));
                                    }
                                  },
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
            return Container();
          },
        ),
      ),
    );
  }
}
