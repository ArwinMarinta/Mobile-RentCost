import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcost/features/product/bloc/detail_bloc.dart';
import 'package:rentcost/features/product/bloc/detail_event.dart';
import 'package:rentcost/features/product/bloc/detail_state.dart';
import 'package:rentcost/features/product/bloc/product_bloc.dart';
import 'package:rentcost/features/product/bloc/product_event.dart';
import 'package:rentcost/features/product/bloc/product_state.dart';
import 'package:rentcost/features/product/model/detail.dart';
import 'package:rentcost/features/stores/bloc/stores_bloc.dart';
import 'package:rentcost/features/stores/bloc/stores_event.dart';
import 'package:rentcost/features/stores/bloc/stores_state.dart';

import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:rentcost/features/stores/model/stock.dart';
import 'package:rentcost/features/users/bloc/user_product_bloc.dart';
import 'package:rentcost/features/users/bloc/user_product_event.dart';

class DetailProductUser extends StatefulWidget {
  final String id;

  const DetailProductUser({required this.id, super.key});

  @override
  _DetailCostumState createState() => _DetailCostumState();
}

class _DetailCostumState extends State<DetailProductUser> {
  TextEditingController stok = TextEditingController();
  TextEditingController sizeId = TextEditingController();

  late String currentId;
  bool? value = false;
  int? selectedStockId;
  String? selectedSizeId;

  @override
  void initState() {
    super.initState();
    currentId = widget.id;
    BlocProvider.of<DetailBloc>(context).add(DetailProduct(id: currentId));
  }

  Map<String, String> sizeMapping = {
    '1': 'S',
    '2': 'M',
    '3': 'L',
    '4': 'XL',
    '5': 'XXL',
  };

  List<String> selectedSizes = [];
  String? existingSizeId;
  String? existingStok;
  String? existingSizeName;

  void onDeleteOrUpdate() {
    setState(() {
      value = false;
      selectedStockId = null;
    });
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
    print(selectedSizeId.toString());
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

        // List<Stock> stockData = data.stock;

        // bool isStockAvailable(String sizeId) {
        //   return stockData
        //       .any((stock) => stock.size.sizeName == sizeId && stock.stok > 0);
        // }

        // List<String> getAvailableSizeOptions() {
        //   // Misalnya sizeMapping berisi mapping ukuran produk
        //   return sizeMapping.entries
        //       .where((entry) => !stockData.any((stock) =>
        //           stock.size.sizeName == entry.key && stock.stok > 0))
        //       .map((entry) => entry.key)
        //       .toList();
        // }

// Menghapus ukuran yang sudah ada dari dropdown

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              scrolledUnderElevation: 0.0,
              backgroundColor: Colors.white,
              centerTitle: true,
              leading: GestureDetector(
                onTap: () {
                  context.go("/shop");
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
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16.0)),
                              ),
                              context: context,
                              isDismissible: false,
                              enableDrag: false,
                              builder: (BuildContext context) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context); // Menutup modal
                                    onDeleteOrUpdate(); // Memperbarui state
                                  },
                                  child: StatefulBuilder(
                                    builder: (BuildContext context,
                                        StateSetter setState) {
                                      return SingleChildScrollView(
                                        child: Container(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 10.0,
                                                  horizontal: 10.0,
                                                ),
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: Colors
                                                          .black, // Warna border
                                                      width:
                                                          0.5, // Ketebalan border
                                                    ),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    // Text
                                                    Expanded(
                                                      child: Center(
                                                        child: Text(
                                                          "Ukuran kostum",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    // Tombol Close
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(
                                                            context); // Menutup modal
                                                        onDeleteOrUpdate(); // Memperbarui state
                                                      },
                                                      child: Center(
                                                        child:
                                                            Icon(Bootstrap.x),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: data.stock.length,
                                                itemBuilder: (context, index) {
                                                  final size =
                                                      data.stock[index];
                                                  return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Checkbox(
                                                            splashRadius: 0,
                                                            fillColor: WidgetStateProperty
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
                                                                  .white;
                                                            }),
                                                            shape:
                                                                const CircleBorder(),
                                                            side:
                                                                const BorderSide(
                                                                    width: 0.6),
                                                            value:
                                                                selectedStockId ==
                                                                    size.id,
                                                            onChanged: size
                                                                    .available
                                                                ? (bool?
                                                                    newValue) {
                                                                    setState(
                                                                        () {
                                                                      // Reset bos checkbox setiap kali ada perubahan
                                                                      value =
                                                                          false;

                                                                      // Toggle selectedStockId
                                                                      if (selectedStockId ==
                                                                          size.id) {
                                                                        selectedStockId =
                                                                            null;
                                                                      } else {
                                                                        selectedStockId =
                                                                            size.id;
                                                                      }
                                                                    });
                                                                  }
                                                                : null,
                                                          ),
                                                          Text(size
                                                              .size.sizeName),
                                                        ],
                                                      ),
                                                      Text(
                                                          "${size.stok} Produk"),
                                                    ],
                                                  );
                                                },
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 10.0,
                                                  horizontal: 10.0,
                                                ),
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    top: BorderSide(
                                                      color: Colors
                                                          .black, // Warna border
                                                      width:
                                                          0.5, // Ketebalan border
                                                    ),
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    BlocListener<StoreBloc,
                                                        StoreState>(
                                                      listener:
                                                          (context, state) {
                                                        if (state
                                                            is StockCreateLoading) {
                                                          showDialog(
                                                            context: context,
                                                            barrierDismissible:
                                                                false,
                                                            builder: (context) =>
                                                                const Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            ),
                                                          );
                                                        } else if (state
                                                            is StockCreateSuccess) {
                                                          Navigator.of(context)
                                                              .pop();
                                                          Navigator.of(context)
                                                              .pop();
                                                          Navigator.of(context)
                                                              .pop(); // Close loading dialog
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Center(
                                                                child: Text(
                                                                  state.message,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ),
                                                              backgroundColor:
                                                                  Colors.white,
                                                              duration:
                                                                  const Duration(
                                                                      seconds:
                                                                          3),
                                                              behavior:
                                                                  SnackBarBehavior
                                                                      .floating,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              margin:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          10,
                                                                      horizontal:
                                                                          20),
                                                            ),
                                                          );

                                                          context
                                                              .read<
                                                                  DetailBloc>()
                                                              .add(DetailProduct(
                                                                  id: currentId));
                                                          onDeleteOrUpdate();
                                                        } else if (state
                                                            is StockCreateFailure) {
                                                          Navigator.of(context)
                                                              .pop();
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Center(
                                                                child: Text(
                                                                  state.error,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                              backgroundColor:
                                                                  Colors.red,
                                                              duration:
                                                                  const Duration(
                                                                      seconds:
                                                                          3),
                                                              behavior:
                                                                  SnackBarBehavior
                                                                      .floating,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              margin:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          10,
                                                                      horizontal:
                                                                          20),
                                                            ),
                                                          );
                                                          onDeleteOrUpdate();
                                                        }
                                                      },
                                                      child: Expanded(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            showCupertinoDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return Material(
                                                                  // Menambahkan Material widget sebagai ancestor
                                                                  color: Colors
                                                                      .transparent, // Agar tetap menggunakan desain Cupertino
                                                                  child:
                                                                      CupertinoAlertDialog(
                                                                    title: Text(
                                                                        'Tambah Stock'),
                                                                    content:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        const SizedBox(
                                                                          child:
                                                                              Text(
                                                                            "Ukuran",
                                                                            style:
                                                                                TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                8.0),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            const SizedBox(height: 8.0),
                                                                            DropdownButtonFormField<String>(
                                                                              value: selectedSizeId,
                                                                              decoration: const InputDecoration(
                                                                                hintText: 'Pilih Ukuran',
                                                                                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                                                                border: OutlineInputBorder(
                                                                                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                                                                                ),
                                                                                enabledBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(color: Color(0xFF8E8E8E), width: 1.0),
                                                                                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                                                                                ),
                                                                                focusedBorder: OutlineInputBorder(
                                                                                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                                                                                  borderSide: BorderSide(color: Color(0xFF881FFF), width: 2.0),
                                                                                ),
                                                                              ),
                                                                              onChanged: (String? newValue) {
                                                                                setState(() {
                                                                                  selectedSizeId = newValue;
                                                                                  if (newValue != null && !selectedSizes.contains(newValue)) {
                                                                                    selectedSizes.add(newValue); // Menambahkan ukuran yang dipilih ke dalam list
                                                                                  }
                                                                                });
                                                                              },
                                                                              items: sizeMapping.keys
                                                                                  .where((sizeId) => !selectedSizes.contains(sizeId)) // Filter ukuran yang sudah dipilih
                                                                                  .map<DropdownMenuItem<String>>((sizeId) {
                                                                                return DropdownMenuItem<String>(
                                                                                  value: sizeId,
                                                                                  child: Text(sizeMapping[sizeId] ?? ''), // Ambil label ukuran dari sizeMapping
                                                                                );
                                                                              }).toList(),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                8.0),
                                                                        const SizedBox(
                                                                          child:
                                                                              Text(
                                                                            "Stok",
                                                                            style:
                                                                                TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                8.0),
                                                                        TextField(
                                                                          controller:
                                                                              stok,
                                                                          keyboardType:
                                                                              TextInputType.number,
                                                                          inputFormatters: [
                                                                            FilteringTextInputFormatter.digitsOnly,
                                                                          ],
                                                                          decoration:
                                                                              const InputDecoration(
                                                                            hintText:
                                                                                'Cth: 1',
                                                                            contentPadding:
                                                                                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                                                            border:
                                                                                OutlineInputBorder(
                                                                              borderRadius: BorderRadius.all(Radius.circular(6.0)),
                                                                            ),
                                                                            enabledBorder:
                                                                                OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Color(0xFF8E8E8E), width: 1.0),
                                                                              borderRadius: BorderRadius.all(Radius.circular(6.0)),
                                                                            ),
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderRadius: BorderRadius.all(Radius.circular(6.0)),
                                                                              borderSide: BorderSide(color: Color(0xFF881FFF), width: 2.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    actions: <Widget>[
                                                                      CupertinoDialogAction(
                                                                        child: Text(
                                                                            'Tutup',
                                                                            style:
                                                                                TextStyle(color: Colors.red)),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop(); // Menutup dialog
                                                                        },
                                                                      ),
                                                                      CupertinoDialogAction(
                                                                        child: Text(
                                                                            'Tambah',
                                                                            style:
                                                                                TextStyle(color: Colors.black)),
                                                                        onPressed:
                                                                            () {
                                                                          final sizeIdText = sizeId
                                                                              .text
                                                                              .trim();
                                                                          final stokText = stok
                                                                              .text
                                                                              .trim();

                                                                          print(
                                                                              selectedSizeId.toString());
                                                                          context.read<StoreBloc>().add(StockCreate(
                                                                              id: currentId,
                                                                              sizeId: selectedSizeId.toString(),
                                                                              stok: stokText));
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        7.0,
                                                                    vertical:
                                                                        8.0),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFF881FFF),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                "Tambah stock",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    BlocListener<StoreBloc,
                                                        StoreState>(
                                                      listener:
                                                          (context, state) {
                                                        if (state
                                                            is StockUpdateLoading) {
                                                          showDialog(
                                                            context: context,
                                                            barrierDismissible:
                                                                false,
                                                            builder: (context) =>
                                                                const Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            ),
                                                          );
                                                        } else if (state
                                                            is StockUpdateSuccess) {
                                                          Navigator.of(context)
                                                              .pop();
                                                          Navigator.of(context)
                                                              .pop();
                                                          Navigator.of(context)
                                                              .pop(); // Close loading dialog
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Center(
                                                                child: Text(
                                                                  state.message,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ),
                                                              backgroundColor:
                                                                  Colors.white,
                                                              duration:
                                                                  const Duration(
                                                                      seconds:
                                                                          3),
                                                              behavior:
                                                                  SnackBarBehavior
                                                                      .floating,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              margin:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          10,
                                                                      horizontal:
                                                                          20),
                                                            ),
                                                          );

                                                          context
                                                              .read<
                                                                  DetailBloc>()
                                                              .add(DetailProduct(
                                                                  id: currentId));
                                                          onDeleteOrUpdate();
                                                        } else if (state
                                                            is StockUpdateFailure) {
                                                          Navigator.of(context)
                                                              .pop();
                                                          Navigator.of(context)
                                                              .pop();
                                                          Navigator.of(context)
                                                              .pop();
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Center(
                                                                child: Text(
                                                                  state.error,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                              backgroundColor:
                                                                  Colors.red,
                                                              duration:
                                                                  const Duration(
                                                                      seconds:
                                                                          3),
                                                              behavior:
                                                                  SnackBarBehavior
                                                                      .floating,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              margin:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          10,
                                                                      horizontal:
                                                                          20),
                                                            ),
                                                          );
                                                          onDeleteOrUpdate();
                                                        }
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 6.0,
                                                                horizontal: 10),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            if (selectedStockId !=
                                                                null) {
                                                              var stockItem = data
                                                                  .stock
                                                                  .firstWhere(
                                                                (item) =>
                                                                    item.id ==
                                                                    selectedStockId,
                                                                // Return a default Stock object if no match is found
                                                              );

                                                              if (stockItem !=
                                                                  null) {
                                                                existingSizeName =
                                                                    stockItem
                                                                        .size
                                                                        .sizeName
                                                                        .toString();
                                                                existingSizeId =
                                                                    stockItem
                                                                        .size.id
                                                                        .toString();

                                                                ;

                                                                existingStok =
                                                                    existingStok =
                                                                        stockItem
                                                                            .stok
                                                                            .toString();

                                                                showCupertinoDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      child:
                                                                          CupertinoAlertDialog(
                                                                        title: Text(
                                                                            'Ubah Stock'),
                                                                        content:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            SizedBox(
                                                                              child: Text(
                                                                                "Ukuran",
                                                                                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(height: 8.0),
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                const SizedBox(height: 8.0),
                                                                                DropdownButtonFormField<String>(
                                                                                  value: selectedSizeId,
                                                                                  decoration: InputDecoration(
                                                                                    hintText: existingSizeName,
                                                                                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                                                                    border: OutlineInputBorder(
                                                                                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                                                                                    ),
                                                                                    enabledBorder: OutlineInputBorder(
                                                                                      borderSide: BorderSide(color: Color(0xFF8E8E8E), width: 1.0),
                                                                                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                                                                                    ),
                                                                                    focusedBorder: OutlineInputBorder(
                                                                                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                                                                                      borderSide: BorderSide(color: Color(0xFF881FFF), width: 2.0),
                                                                                    ),
                                                                                  ),
                                                                                  onChanged: (String? newValue) {
                                                                                    setState(() {
                                                                                      selectedSizeId = newValue;
                                                                                      if (newValue != null && !selectedSizes.contains(newValue)) {
                                                                                        selectedSizes.add(newValue);
                                                                                      }
                                                                                    });
                                                                                  },
                                                                                  items: sizeMapping.keys
                                                                                      .where((sizeId) => !selectedSizes.contains(sizeId)) // Filter ukuran yang sudah dipilih
                                                                                      .map<DropdownMenuItem<String>>((sizeId) {
                                                                                    return DropdownMenuItem<String>(
                                                                                      value: sizeId,
                                                                                      child: Text(sizeMapping[sizeId] ?? ''), // Ambil label ukuran dari sizeMapping
                                                                                    );
                                                                                  }).toList(),
                                                                                )
                                                                              ],
                                                                            ),
                                                                            const SizedBox(height: 8.0),
                                                                            const SizedBox(
                                                                              child: Text(
                                                                                "Stok",
                                                                                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(height: 8.0),
                                                                            TextField(
                                                                              controller: stok..text = existingStok ?? stok.text,
                                                                              keyboardType: TextInputType.number,
                                                                              inputFormatters: [
                                                                                FilteringTextInputFormatter.digitsOnly,
                                                                              ],
                                                                              decoration: const InputDecoration(
                                                                                hintText: "ex: 1",
                                                                                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                                                                border: OutlineInputBorder(
                                                                                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                                                                                ),
                                                                                enabledBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(color: Color(0xFF8E8E8E), width: 1.0),
                                                                                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                                                                                ),
                                                                                focusedBorder: OutlineInputBorder(
                                                                                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                                                                                  borderSide: BorderSide(color: Color(0xFF881FFF), width: 2.0),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        actions: <Widget>[
                                                                          CupertinoDialogAction(
                                                                            child:
                                                                                Text('Tutup', style: TextStyle(color: Colors.black)),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.of(context).pop(); // Close the dialog
                                                                            },
                                                                          ),
                                                                          CupertinoDialogAction(
                                                                            child:
                                                                                Text('Ubah', style: TextStyle(color: Colors.black)),
                                                                            onPressed:
                                                                                () {
                                                                              final stokText = stok.text.trim().isEmpty ? existingStok : stok.text.trim();

                                                                              final sizeIdText = (selectedSizeId == null) ? existingSizeId : selectedSizeId;

                                                                              // Only proceed if selectedSizeId is not null
                                                                              if (sizeIdText != null && stokText != null) {
                                                                                context.read<StoreBloc>().add(StockUpdate(
                                                                                      id: selectedStockId.toString(),
                                                                                      sizeId: sizeIdText.toString(),
                                                                                      stok: stokText,
                                                                                    ));
                                                                              }
                                                                            },
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              }
                                                            }
                                                          },
                                                          child: Center(
                                                            child: Icon(
                                                              Bootstrap
                                                                  .pencil_square,
                                                              color:
                                                                  Colors.yellow,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    BlocListener<StoreBloc,
                                                        StoreState>(
                                                      listener:
                                                          (context, state) {
                                                        if (state
                                                            is StockDeleteLoading) {
                                                          showDialog(
                                                            context: context,
                                                            barrierDismissible:
                                                                false,
                                                            builder: (context) =>
                                                                const Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            ),
                                                          );
                                                        } else if (state
                                                            is StockDeleteSuccess) {
                                                          Navigator.of(context)
                                                              .pop();
                                                          Navigator.of(context)
                                                              .pop(); // Close loading dialog
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Center(
                                                                child: Text(
                                                                  state.message,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ),
                                                              backgroundColor:
                                                                  Colors.white,
                                                              duration:
                                                                  const Duration(
                                                                      seconds:
                                                                          3),
                                                              behavior:
                                                                  SnackBarBehavior
                                                                      .floating,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              margin:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          10,
                                                                      horizontal:
                                                                          20),
                                                            ),
                                                          );

                                                          context
                                                              .read<
                                                                  DetailBloc>()
                                                              .add(DetailProduct(
                                                                  id: currentId));
                                                        } else if (state
                                                            is StockDeleteFailure) {
                                                          Navigator.of(context)
                                                              .pop();
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Center(
                                                                child: Text(
                                                                  state.error,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                              backgroundColor:
                                                                  Colors.red,
                                                              duration:
                                                                  const Duration(
                                                                      seconds:
                                                                          3),
                                                              behavior:
                                                                  SnackBarBehavior
                                                                      .floating,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              margin:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          10,
                                                                      horizontal:
                                                                          20),
                                                            ),
                                                          );
                                                        }
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 6.0,
                                                                horizontal: 10),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            if (selectedStockId !=
                                                                null) {
                                                              context
                                                                  .read<
                                                                      StoreBloc>()
                                                                  .add(StockDelete(
                                                                      id: selectedStockId
                                                                          .toString()));
                                                            } else {
                                                              null;
                                                            }
                                                          },
                                                          child: Center(
                                                            child: Icon(
                                                              Bootstrap.trash,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
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
                              "Lihat Stock",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600), // Pusatkan teks
                            ),
                          ),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          child: GestureDetector(
                            onTap: () {
                              context.go('/update-product/${data.id}');
                            },
                            child: Center(
                              child: Icon(
                                Bootstrap.pencil_square,
                                color: Colors.yellow,
                              ),
                            ),
                          )),
                      BlocListener<ProductBloc, ProductState>(
                        listener: (context, state) {
                          if (state is ProductDeleteLoading) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else if (state is ProductDeleteSuccess) {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Center(
                                  child: Text(
                                    state.message,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                backgroundColor: Colors.white,
                                duration: const Duration(seconds: 3),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                              ),
                            );

                            context.read<ProductUserBloc>().add(ProductUser());
                            context.go('/costum-tenant');
                          } else if (state is ProductDeleteFailure) {
                            Navigator.of(context).pop();
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
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                              ),
                            );
                          }
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            child: GestureDetector(
                              onTap: () {
                                showCupertinoDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CupertinoAlertDialog(
                                      title: const Text("Hapus Kostum"),
                                      content: const Text(
                                          "Apakah Anda yakin ingin menghapus kostum ini?"),
                                      actions: <Widget>[
                                        CupertinoDialogAction(
                                          child: Text(
                                            'Tutup',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Menutup dialog
                                          },
                                        ),
                                        CupertinoDialogAction(
                                          child: Text(
                                            'Hapus',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Tutup dialog
                                            if (currentId.isNotEmpty) {
                                              context.read<ProductBloc>().add(
                                                  ProductDeleteRequest(
                                                      id: currentId));
                                            } else {
                                              null;
                                            }
                                            // Menutup dialog
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Center(
                                child: Icon(
                                  Bootstrap.trash,
                                  color: Colors.red,
                                ),
                              ),
                            )),
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
