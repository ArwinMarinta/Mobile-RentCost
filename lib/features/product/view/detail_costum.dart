import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcost/features/product/bloc/detail_bloc.dart';
import 'package:rentcost/features/product/bloc/detail_event.dart';
import 'package:rentcost/features/product/bloc/detail_state.dart';
import 'package:rentcost/features/widget/add_cart_modal.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';

class DetailCostum extends StatefulWidget {
  final String id;

  const DetailCostum({required this.id, super.key});

  @override
  _DetailCostumState createState() => _DetailCostumState();
}

class _DetailCostumState extends State<DetailCostum> {
  late String currentId;
  bool? value = false;
  int? selectedStockId;

  @override
  void initState() {
    super.initState();
    currentId = widget.id;
    BlocProvider.of<DetailBloc>(context).add(DetailProduct(id: currentId));
  }

  // @override
  // void didUpdateWidget(covariant DetailCostum oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (widget.id != oldWidget.id) {
  //     setState(() {
  //       currentId = widget.id;
  //     });
  //     BlocProvider.of<DetailBloc>(context).add(DetailProduct(id: currentId));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailBloc, DetailState>(builder: (context, state) {
      if (state is DetailLoading) {
        return Scaffold(
          backgroundColor: Colors.white, // Latar belakang putih
          body: const Center(
            child: CircularProgressIndicator(), // Indikator loading
          ),
        );
      } else if (state is DetailProductState) {
        final data = state.detail.data;
        return Scaffold(
          appBar: AppBar(
              scrolledUnderElevation: 0.0,
              backgroundColor: Colors.white,
              centerTitle: true,
              leading: GestureDetector(
                onTap: () {
                  context.go("/");
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 2, vertical: 2)),
                  Text(
                    "Detail",
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )),
          body: SingleChildScrollView(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                    // Radius untuk sudut membulat
                    child: Image.network(
                      data.imageUrl,
                      fit: BoxFit.cover,
                      width: double
                          .infinity, // Agar gambar memenuhi lebar container
                      height: 300.0, // Atur tinggi gambar sesuai kebutuhan
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(data.productName),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 8.0),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 0.5),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Row(
                              children: [
                                Text(data.rate.toString()),
                                const SizedBox(
                                  width: 6.0,
                                ),
                                const Icon(
                                  Bootstrap.star_fill,
                                  size: 13.0,
                                  color: Color(0xFFF8B84E),
                                ),
                                const SizedBox(
                                  width: 6.0,
                                ),
                                const Text('|'),
                                const SizedBox(
                                  width: 6.0,
                                ),
                                Text(data.rentalAmount.toString())
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        data.productName,
                        style: const TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    'Rp. ${data.price} / 3 Hari',
                    style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF881FFF)),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Variasi Ukuran:",
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(
                          height: 40.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: data.stock.length,
                            itemBuilder: (context, index) {
                              final stock = data.stock[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 6),
                                child: GestureDetector(
                                  onTap: null,
                                  child: Container(
                                    width: 60,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      "${stock.size.sizeName}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 14.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1), // Warna shadow
                          offset:
                              const Offset(0, -1), // Menggeser shadow ke atas
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
                      GestureDetector(
                        onTap: () {
                          context.go('/cart');
                        },
                        child: const Icon(Bootstrap.cart),
                      ),
                      const SizedBox(
                        width: 60.0,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet<void>(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16.0)),
                              ),
                              context: context,
                              builder: (BuildContext context) {
                                return SingleChildScrollView(
                                  // Membuat konten bisa scroll jika melebihi tinggi
                                  child: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.black,
                                                      width: 0.5))),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6.0),
                                          child: Column(
                                            children: [
                                              Icon(Bootstrap.chevron_down),
                                              const SizedBox(height: 6.0),
                                              Text(
                                                "Pilih Ukuran",
                                                style:
                                                    TextStyle(fontSize: 16.0),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        // ListView.builder yang mengukur tinggi sesuai jumlah item
                                        ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: data.stock.length,
                                          itemBuilder: (context, index) {
                                            final size = data.stock[index];
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Checkbox(
                                                      splashRadius: 0,
                                                      fillColor:
                                                          WidgetStateProperty
                                                              .resolveWith<
                                                                  Color?>((Set<
                                                                      WidgetState>
                                                                  states) {
                                                        if (states.contains(
                                                            WidgetState
                                                                .selected)) {
                                                          return const Color(
                                                              0xFF881FFF);
                                                        }
                                                        return Colors
                                                            .white; // Warna saat tidak dicentang
                                                      }),
                                                      shape:
                                                          const CircleBorder(),
                                                      side: const BorderSide(
                                                          width: 0.6),
                                                      value: selectedStockId ==
                                                          size.id,

                                                      onChanged: size
                                                                  .available &&
                                                              selectedStockId ==
                                                                  null
                                                          ? (bool? newValue) {
                                                              setState(() {
                                                                selectedStockId =
                                                                    size.id;
                                                              });
                                                            }
                                                          : null, // Disable checkbox jika available = false atau sudah ada yang dipilih
                                                    ),
                                                    Text(size.size.sizeName)
                                                  ],
                                                ),
                                                // Tampilkan stok produk meskipun available false
                                                Text("${size.stok} Produk"),
                                              ],
                                            );
                                          },
                                        ),
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  top: BorderSide(
                                                      color: Colors.black,
                                                      width: 0.5))),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6.0),
                                          child: GestureDetector(
                                            onTap: selectedStockId == null
                                                ? null // Tidak bisa lanjut jika belum memilih barang
                                                : () {
                                                    // Lakukan aksi jika sudah memilih barang
                                                  },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 14),
                                              decoration: BoxDecoration(
                                                color: Color(0xFF881FFF),
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                              ),
                                              child: const Text(
                                                "Masukkan Keranjang",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 14),
                              decoration: BoxDecoration(
                                color: Color(0xFF881FFF),
                                border:
                                    Border.all(color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: const Text(
                                "Masukkan Keranjang",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    fontWeight:
                                        FontWeight.w600), // Pusatkan teks
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      } else if (state is DetailFailure) {
        return Center(child: Text('Error loading details'));
      }

      return Container();
    });
  }
}
