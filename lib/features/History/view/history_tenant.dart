import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcost/features/History/bloc/histori_bloc.dart';
import 'package:rentcost/features/History/bloc/histori_event.dart';
import 'package:rentcost/features/History/bloc/histori_state.dart';
import 'package:rentcost/features/History/bloc/histori_user_bloc.dart';
import 'package:rentcost/features/History/bloc/histori_user_event.dart';
import 'package:rentcost/features/History/model/histori.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class HistoryTenant extends StatefulWidget {
  const HistoryTenant({super.key});

  @override
  State<HistoryTenant> createState() => _HistoryTenantState();
}

class _HistoryTenantState extends State<HistoryTenant> {
  String selectStatus = 'diproses';
  String? updateStatus;

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulasi waktu refresh
    setState(() {
      context.read<HistoriUserBloc>().add(HistoriUserUserRequest());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HistoriBloc, HistoriState>(
      listener: (context, state) {
        if (state is UpdateStatusLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is UpdateStatusSuccess) {
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
          context.read<HistoriBloc>().add(HistoriTenantRequest());
          context.read<HistoriUserBloc>().add(HistoriUserUserRequest());
        } else if (state is UpdateStatusFailure) {
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
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2)),
              Text(
                "Rentalan Saya",
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
                            "selesai",
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
          child: BlocBuilder<HistoriBloc, HistoriState>(
            builder: (context, state) {
              if (state is HistoriInitial) {
                context.read<HistoriBloc>().add(HistoriTenantRequest());
              } else if (state is HistoriTenantLoading) {
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
              } else if (state is HistoriTenantLoaded) {
                final historyData = state.history.data;

                // updateStatus = historyData.first.status;

                // if (selectStatus.isEmpty && historyData.isNotEmpty) {
                //   setState(() {
                //     updateStatus =
                //         historyData.first.status; // Atur ke status item pertama
                //   });
                // }

                List<HistoryItem> filteredHistory = historyData
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
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        child: DropdownButton<
                                                            String>(
                                                          value: data
                                                              .status, // Status sesuai dengan ID
                                                          onChanged: (String?
                                                              newValue) {
                                                            setState(() {
                                                              print(newValue);
                                                              if (newValue !=
                                                                  null) {
                                                                context
                                                                    .read<
                                                                        HistoriBloc>()
                                                                    .add(UpdateStatusRequest(
                                                                        transaction_id:
                                                                            data
                                                                                .id,
                                                                        status:
                                                                            newValue));
                                                              }
                                                            });
                                                          },
                                                          items: <String>[
                                                            'diproses',
                                                            'dikirim',
                                                            'selesai'
                                                          ].map<
                                                              DropdownMenuItem<
                                                                  String>>(
                                                            (String value) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: value,
                                                                child: Text(
                                                                    value), // Menampilkan status
                                                              );
                                                            },
                                                          ).toList(),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          context.go(
                                                              '/detail-history');
                                                        },
                                                        child: Icon(
                                                          Bootstrap
                                                              .chevron_right,
                                                          size: 18,
                                                        ),
                                                      )
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
                                                                              data.product.category.categoryName,
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
              } else if (state is HistoriTenantFailure) {
                return Container(
                  child: Center(
                    child: Text(state.error),
                  ),
                );
              }

              return Container(
                child: Center(
                  child: Text(''),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
