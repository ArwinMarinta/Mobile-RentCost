// import 'package:RentCost/features/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcost/features/cart/bloc/cart_bloc.dart';
import 'package:rentcost/features/cart/bloc/cart_event.dart';
import 'package:rentcost/features/cart/bloc/cart_state.dart';
import 'package:rentcost/features/view/navigation_bar.dart';
import 'package:rentcost/features/widget/add_cart_modal.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shimmer/shimmer.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<Map<String, int>> selectedProductIds = [];
  int totalPrice = 0;

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulasi waktu refresh
    setState(() {
      context.read<CartBloc>().add(CartRequest());
    });
  }

  @override
  Widget build(BuildContext context) {
    print(selectedProductIds);
    // Assuming cartList is predefined
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartDeleteLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is CartDeleteSuccess) {
          Navigator.of(context).pop(); // Close loading dialog

          context.read<CartBloc>().add(CartRequest());
        } else if (state is CartDeleteFailure) {
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
          elevation: 0,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2)),
              Text(
                "KERANJANG",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartInitial) {
                context.read<CartBloc>().add(CartRequest());
              } else if (state is CartLoading) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  height: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 3, // Jumlah shimmer card
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black45, width: 0.2),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6.0)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 0.5,
                                  blurRadius: 1,
                                  offset: const Offset(1, 2),
                                )
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Placeholder untuk gambar
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(6.0),
                                    topRight: Radius.circular(6.0),
                                  ),
                                  child: Container(
                                    color: Colors.grey.shade400,
                                    width: double.infinity,
                                    height: 150,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (state is CartLoaded) {
                final address = state.cart.data.address;

                return SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black45, width: 0.2),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6.0)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 0.5,
                                  blurRadius: 1,
                                  offset: const Offset(1, 2),
                                )
                              ]),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(
                                      Bootstrap.geo_alt,
                                      size: 25.0,
                                    ),
                                    SizedBox(
                                      width: 16.0,
                                    ),
                                    state.cart.data.address != null &&
                                            state.cart.data.address?.address !=
                                                null
                                        ? Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${address?.address?.username} | ${address?.address?.phoneNumber}',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  '${address?.address?.address1} ${address?.address?.address2} ${address?.address?.city} ${address?.address?.state} ${address?.address?.zipCode}',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                ),
                                              ],
                                            ),
                                          )
                                        : Expanded(
                                            child: Text(
                                            "Belum ada alamat yang di pilih",
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 6.0),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    context.go('/select_address');
                                  });
                                },
                                child: const Text("Ubah"),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        state.cart.data.cartItem.isEmpty
                            ? Column(
                                children: [
                                  Center(
                                    child: Text("Belum ada produk"),
                                  ),
                                ],
                              )
                            : Column(
                                children: state.cart.data.cartItem.map((data) {
                                  // final isSelected = selectedProductIds
                                  //     .contains(data.product.id);

                                  final isSelected = selectedProductIds.any(
                                    (item) =>
                                        item['productId'] == data.product.id &&
                                        item['sizeId'] == data.size.id,
                                  );

                                  return GestureDetector(
                                    onTap: () {
                                      context.go('/detail/${data.product.id}');
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey,
                                            width: 0.2), // Memberi border
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Checkbox(
                                                    splashRadius: 0,
                                                    fillColor:
                                                        WidgetStateProperty
                                                            .resolveWith<
                                                                Color?>(
                                                      (Set<WidgetState>
                                                          states) {
                                                        if (states.contains(
                                                            WidgetState
                                                                .selected)) {
                                                          return const Color(
                                                              0xFF881FFF);
                                                        }
                                                        return Colors.white;
                                                      },
                                                    ),
                                                    shape: const CircleBorder(),
                                                    side: const BorderSide(
                                                        width: 0.6),
                                                    value: isSelected,
                                                    onChanged: (bool? value) {
                                                      if (value != null) {
                                                        setState(() {
                                                          if (value) {
                                                            // Menambah item yang dipilih
                                                            selectedProductIds
                                                                .add({
                                                              'productId': data
                                                                  .product.id,
                                                              'sizeId':
                                                                  data.size.id,
                                                            });

                                                            totalPrice += data
                                                                .product.price;
                                                          } else {
                                                            // Menghapus item yang tidak dipilih
                                                            selectedProductIds
                                                                .removeWhere(
                                                              (item) =>
                                                                  item['productId'] ==
                                                                      data.product
                                                                          .id &&
                                                                  item['sizeId'] ==
                                                                      data.size
                                                                          .id,
                                                            );
                                                            totalPrice -= data
                                                                .product.price;
                                                          }
                                                        });
                                                      }
                                                    },
                                                  ),

                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Image.network(
                                                      data.product.imageUrl,
                                                      width: 80.0,
                                                      height: 80.0,
                                                      fit: BoxFit.cover,
                                                      errorBuilder:
                                                          (BuildContext context,
                                                              Object error,
                                                              StackTrace?
                                                                  stackTrace) {
                                                        return const Icon(Icons
                                                            .error); // Atau widget lain untuk menampilkan error
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                      width:
                                                          20), // Jarak antar gambar dan teks
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        data.product
                                                            .productName,
                                                        style: const TextStyle(
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(data.product.category
                                                          .categoryName),
                                                      const SizedBox(
                                                        height: 10.0,
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                              "Ukuran: "),
                                                          GestureDetector(
                                                            onTap: null,
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          10.0),
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .black,
                                                                      width:
                                                                          0.2),
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                          Radius.circular(
                                                                              4.0))),
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    data.size
                                                                        .sizeName,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          15.0,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 10.0,
                                                      ),
                                                      Text(
                                                        "Rp. ${data.product.price} / 3 Hari",
                                                        style: const TextStyle(
                                                            fontSize: 16.0,
                                                            color: Color(
                                                                0xFF881FFF),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 12.0,
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                context.read<CartBloc>().add(
                                                    CartDeleteItem(
                                                        id: state.cart.data
                                                            .cartItem.first.id
                                                            .toString()));
                                              },
                                              child: const Icon(
                                                Bootstrap.x,
                                                size: 25,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              )
                      ],
                    ),
                  ),
                );
              } else if (state is CartFailure) {
                return Container(
                  child: Center(
                    child: Text(state.error),
                  ),
                );
              }
              return Container();
            },
          ),
        ),
        bottomNavigationBar: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min, // Pastikan ukuran kolom minimal
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 12.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1), // Warna shadow
                        offset: const Offset(0, -1), // Menggeser shadow ke atas
                        blurRadius: 1, // Jarak blur shadow
                        spreadRadius: 1, // Jarak spread shadow
                      ),
                    ],
                    border: const Border(

                        // top: BorderSide(width: 0.3, color: Colors.black),
                        bottom: BorderSide(width: 0.5, color: Colors.black))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'Rp $totalPrice',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (selectedProductIds.isNotEmpty && totalPrice >= 0) {
                          context.go(
                            '/payment?selectedProductIds=${selectedProductIds.join(',')}&totalPrice=$totalPrice',
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: const BoxDecoration(
                            color: Color(0xFF881FFF),
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0))),
                        child: const Text(
                          "Lanjut \n Pembayaran",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const CustomNavigationBar(selectedIndex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
