import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcost/features/History/bloc/histori_bloc.dart';
import 'package:rentcost/features/History/bloc/histori_event.dart';
import 'package:rentcost/features/History/bloc/histori_user_bloc.dart';
import 'package:rentcost/features/History/bloc/histori_user_event.dart';
import 'package:rentcost/features/cart/bloc/cart_bloc.dart';
import 'package:rentcost/features/cart/bloc/cart_event.dart';
import 'package:rentcost/features/payment/bloc/payment_bloc.dart';
import 'package:rentcost/features/payment/bloc/payment_event.dart';
import 'package:rentcost/features/payment/bloc/payment_state.dart';
import 'package:rentcost/features/product/bloc/product_bloc.dart';
import 'package:rentcost/features/product/bloc/product_event.dart';
import 'package:rentcost/features/users/bloc/user_product_bloc.dart';
import 'package:rentcost/features/users/bloc/user_product_event.dart';
import 'package:rentcost/features/widget/cart_payment.dart';
import 'package:rentcost/features/widget/detail_payment.dart';
import 'package:rentcost/features/widget/payment_success.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:timelines_plus/timelines_plus.dart';

class Payment extends StatefulWidget {
  final String selectedProductIds;
  final String totalPrice;
  const Payment(
      {required this.selectedProductIds, required this.totalPrice, super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  // // String currentStatus = 'Bayar';
  // late List<int> selectedProductIds;
  // late int totalPrice;

  String? showFileName = "";
  String errorMessage = '';
  int maxSizeInBytes = 3 * 1024 * 1024;
  FilePickerResult? filePickerResult;

  @override
  Widget build(BuildContext context) {
    final price = widget.totalPrice;
    final productId = widget.selectedProductIds;

    print(price);
    print(productId);
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is PaymentLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is PaymentSuccessEvent) {
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
          context.read<CartBloc>().add(CartRequest());
          context.read<HistoriUserBloc>().add(HistoriUserUserRequest());
          context.read<ProductBloc>().add(ProductFilter());
          context.go("/cart");
        } else if (state is PaymentFailure) {
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
              context.go("/cart");
            },
            child: const Icon(
              FontAwesome.chevron_left_solid,
              color: Colors.black,
            ),
          ),
          elevation: 0,
          title: const Text(
            "pembayaran",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                // Container(
                //   // color: Colors.red,
                //   width: double.infinity,
                //   child: Center(
                //       child: _buildTimeline(['Detail', 'Pembayaran', 'Selesai'])),
                // ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                          children: [
                            // Container(
                            //     width: double.infinity,
                            //     decoration: BoxDecoration(
                            //         border: Border(
                            //             bottom: BorderSide(
                            //                 color: Colors.black, width: 0.5))),
                            //     padding: const EdgeInsets.symmetric(
                            //         horizontal: 16.0, vertical: 16.0),
                            //     child: Text('Nomor Pesanan: 63823683')),
                            Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.black, width: 0.5))),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        "Transfer ke salah satu bank di bawah",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            // Radius untuk sudut membulat
                                            child: Image.asset(
                                              'assets/BNI.jpg',
                                              // fit: BoxFit.cover,
                                              width: 100.0,
                                              height: 100.0,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20.0,
                                          ),
                                          Text(
                                            "6382653965235",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2.0,
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            // Radius untuk sudut membulat
                                            child: Image.asset(
                                              'assets/836405_720.jpg',
                                              // fit: BoxFit.cover,
                                              width: 100.0,
                                              height: 100.0,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20.0,
                                          ),
                                          Text(
                                            "489347648434",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                            Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.black, width: 0.5))),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total Pesanan",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(
                                      price,
                                      style: TextStyle(fontSize: 16.0),
                                    )
                                  ],
                                )),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    child: Text(
                                      "Bukti Pembayaran",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(8.0)),
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 0.5),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      filePickerResult =
                                                          await FilePicker
                                                              .platform
                                                              .pickFiles(
                                                        type: FileType.custom,
                                                        allowedExtensions: [
                                                          'jpeg',
                                                          'jpg',
                                                          'png'
                                                        ],
                                                      );

                                                      if (filePickerResult !=
                                                          null) {
                                                        var file =
                                                            filePickerResult!
                                                                .files.first;
                                                        if (file.size >
                                                            maxSizeInBytes) {
                                                          setState(() {
                                                            errorMessage =
                                                                'Ukuran file tidak boleh lebih dari 1 MB';
                                                            showFileName = '';
                                                          });
                                                        } else {
                                                          // Jika ukuran file sesuai, perbarui state dengan nama file
                                                          setState(() {
                                                            showFileName =
                                                                file.name;
                                                            errorMessage =
                                                                ''; // Clear any previous error message
                                                          });
                                                        }
                                                      }
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 14.0,
                                                          horizontal: 8.0),
                                                      backgroundColor:
                                                          const Color(
                                                              0xFF881FFF),
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8.0)),
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      'Pilih File',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        showFileName!,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
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
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: GestureDetector(
            onTap: () {
              if (filePickerResult == null || filePickerResult!.files.isEmpty) {
                setState(() {
                  errorMessage = 'Pilih gambar untuk banner';
                });
                return;
              }

              setState(() {
                errorMessage = '';
              });

              if (filePickerResult != null &&
                  filePickerResult!.files.isNotEmpty) {
                context.read<PaymentBloc>().add(PaymentRequest(
                    price: price,
                    paymentImage: filePickerResult?.files.first.path ?? '',
                    productId: productId));
              }
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF881FFF),
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Kirim',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
