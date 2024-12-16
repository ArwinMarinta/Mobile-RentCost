import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcost/features/History/bloc/histori_bloc.dart';
import 'package:rentcost/features/History/bloc/histori_event.dart';
import 'package:rentcost/features/History/bloc/histori_user_bloc.dart';
import 'package:rentcost/features/History/bloc/histori_user_event.dart';
import 'package:rentcost/features/History/bloc/histori_user_state.dart';
import 'package:rentcost/features/History/model/histori_user.dart';
import 'package:rentcost/features/product/bloc/product_bloc.dart';
import 'package:rentcost/features/product/bloc/product_event.dart';

import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({super.key});

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  String selectStatus = 'diproses';

  int _rating = 0; // Variabel untuk menyimpan rating

  // Fungsi untuk mengatur rating
  void _setRating(int rating) {
    setState(() {
      _rating = rating;
    });
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulasi waktu refresh
    setState(() {
      context.read<HistoriUserBloc>().add(HistoriUserUserRequest());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HistoriUserBloc, HistoriUserState>(
      listener: (context, state) {
        if (state is RatingProductLoading) {
        } else if (state is RatingProductSuccess) {
          context.read<HistoriUserBloc>().add(HistoriUserUserRequest());
          context.read<ProductBloc>().add(ProductFilter());
          context.read<HistoriBloc>().add(HistoriTenantRequest());
        } else if (state is RatingProductFailure) {
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
                "Pesanan Saya",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectStatus = "diproses";
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          decoration: BoxDecoration(
                              border: selectStatus == "diproses"
                                  ? Border(
                                      bottom: BorderSide(
                                          color: Color(0xFF881FFF), width: 3.0))
                                  : Border(
                                      bottom: BorderSide(
                                          color: Colors.white, width: 3.0))),
                          child: Center(
                            child: Text(
                              "Diproses",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectStatus = "dikirim";
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          decoration: BoxDecoration(
                              border: selectStatus == "dikirim"
                                  ? Border(
                                      bottom: BorderSide(
                                          color: Color(0xFF881FFF), width: 3.0))
                                  : Border(
                                      bottom: BorderSide(
                                          color: Colors.white, width: 3.0))),
                          child: Text(
                            "Dikirim",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectStatus = "selesai";
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          decoration: BoxDecoration(
                              border: selectStatus == "selesai"
                                  ? Border(
                                      bottom: BorderSide(
                                          color: Color(0xFF881FFF), width: 3.0))
                                  : Border(
                                      bottom: BorderSide(
                                          color: Colors.white, width: 3.0))),
                          child: Text(
                            "Selesai",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          child: BlocBuilder<HistoriUserBloc, HistoriUserState>(
            builder: (context, state) {
              if (state is HistoriUserInitial) {
                context.read<HistoriUserBloc>().add(HistoriUserUserRequest());
              } else if (state is HistoriUserLoading) {
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
              } else if (state is HistoriUserLoaded) {
                final historyData = state.history.data;

                List<HistoryItemUser> filteredHistory = historyData
                    .where((data) => data.status == selectStatus)
                    .toList();

                return filteredHistory.isEmpty
                    ? Column(
                        children: [
                          Expanded(
                              child: Center(
                            child: Text("Belum ada history"),
                          ))
                        ],
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: filteredHistory.length,
                                itemBuilder: (context, index) {
                                  final data = filteredHistory[index];
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            // margin: const EdgeInsets.symmetric(vertical: 8.0),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0,
                                                horizontal: 16.0),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey,
                                                  width: 0.2), // Memberi border
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            Text(data.status[0]
                                                                    .toUpperCase() +
                                                                data.status
                                                                    .substring(
                                                                        1)),
                                                            const SizedBox(
                                                              width: 10.0,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      data.status == "selesai"
                                                          ? data.rating == false
                                                              ? (GestureDetector(
                                                                  onTap: () {
                                                                    showCupertinoDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        double
                                                                            rating =
                                                                            0.0; // Rating default

                                                                        return CupertinoAlertDialog(
                                                                          title:
                                                                              Container(
                                                                            padding:
                                                                                const EdgeInsets.only(bottom: 6.0),
                                                                            child:
                                                                                Text('Beri Penilaian'),
                                                                          ),
                                                                          content:
                                                                              StatefulBuilder(
                                                                            builder:
                                                                                (BuildContext context, StateSetter setState) {
                                                                              return Column(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                children: [
                                                                                  CupertinoSlider(
                                                                                    value: rating,
                                                                                    min: 0.0,
                                                                                    max: 5.0,
                                                                                    divisions: 5,
                                                                                    onChanged: (double value) {
                                                                                      setState(() {
                                                                                        rating = value;
                                                                                      });
                                                                                    },
                                                                                  ),
                                                                                  Text(
                                                                                    rating.toStringAsFixed(1),
                                                                                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                                                                  ), // Menampilkan nilai rating
                                                                                ],
                                                                              );
                                                                            },
                                                                          ),
                                                                          actions: <Widget>[
                                                                            CupertinoDialogAction(
                                                                              child: Text(
                                                                                'Tutup',
                                                                                style: TextStyle(color: Colors.black),
                                                                              ),
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop(); // Menutup dialog
                                                                              },
                                                                            ),
                                                                            CupertinoDialogAction(
                                                                              child: Text(
                                                                                'kirim',
                                                                                style: TextStyle(color: Colors.black),
                                                                              ),
                                                                              onPressed: () {
                                                                                if (rating != 0) {
                                                                                  context.read<HistoriUserBloc>().add(PostRatingRequest(totalRating: _rating, productId: data.product.id, transactiId: data.id));
                                                                                }
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    child:
                                                                        Center(
                                                                      child: Text(
                                                                          "Beri Rating"),
                                                                    ),
                                                                  )))
                                                              : Container()
                                                          : Container()
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        child: Row(
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              child:
                                                                  Image.network(
                                                                data.product
                                                                    .imageUrl,
                                                                width: 80.0,
                                                                height: 80.0,
                                                                fit: BoxFit
                                                                    .cover,
                                                                errorBuilder: (BuildContext
                                                                        context,
                                                                    Object
                                                                        error,
                                                                    StackTrace?
                                                                        stackTrace) {
                                                                  return const Icon(
                                                                      Icons
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
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        16.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                Text(data
                                                                    .product
                                                                    .category
                                                                    .categoryName),
                                                                const SizedBox(
                                                                  height: 10.0,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    const Text(
                                                                        "Ukuran: "),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          null,
                                                                      child:
                                                                          Container(
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            horizontal:
                                                                                10.0),
                                                                        decoration: BoxDecoration(
                                                                            border:
                                                                                Border.all(color: Colors.black, width: 0.2),
                                                                            borderRadius: const BorderRadius.all(Radius.circular(4.0))),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Text(
                                                                              data.size.sizeName,
                                                                              style: const TextStyle(
                                                                                fontSize: 15.0,
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
                                                                      fontSize:
                                                                          16.0,
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
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      );
              } else if (state is HistoriUserFailure) {
                return Container(
                  child: Center(
                    child: Text(state.error),
                  ),
                );
              }

              return Container(
                child: Center(
                  child: Text(""),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
