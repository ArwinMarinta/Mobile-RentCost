import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcost/features/stores/model/product.dart';
import 'package:rentcost/features/users/bloc/user_product_bloc.dart';
import 'package:rentcost/features/users/bloc/user_product_event.dart';
import 'package:rentcost/features/users/bloc/user_product_state.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:rentcost/features/model/costum.dart';
import 'package:rentcost/features/widget/card_detail_product_user.dart';
import 'package:shimmer/shimmer.dart';

class MyRental extends StatelessWidget {
  MyRental({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    context.read<ProductUserBloc>().add(ProductUser());
    await Future.delayed(Duration(seconds: 2));
  }

  final List<Costum> costum = costumList;
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
            Padding(padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2)),
            Text(
              "Rentalan Saya",
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(50.0),
        //   child: Container(
        //     padding:
        //         const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        //     child: TextField(
        //       decoration: InputDecoration(
        //         hintText: "Cari Kostum...",
        //         filled: true,
        //         fillColor: const Color.fromARGB(255, 224, 224, 224),
        //         border: const OutlineInputBorder(
        //           borderRadius: BorderRadius.all(Radius.circular(6.0)),
        //           borderSide: BorderSide(color: Colors.white, width: 0),
        //         ),
        //         focusedBorder: const OutlineInputBorder(
        //           borderRadius: BorderRadius.all(Radius.circular(6.0)),
        //           borderSide: BorderSide(
        //               color: Colors.white,
        //               width: 1.0), // Mengatur border saat fokus
        //         ),
        //         enabledBorder: const OutlineInputBorder(
        //           borderRadius: BorderRadius.all(Radius.circular(6.0)),
        //           borderSide: BorderSide(
        //               color: Colors.white,
        //               width: 1.0), // Mengatur border saat tidak fokus
        //         ),
        //         contentPadding: const EdgeInsets.symmetric(
        //             horizontal: 10.0, vertical: 12.0),
        //       ),
        //     ),
        //   ),
        // ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _onRefresh(context),
        child: BlocBuilder<ProductUserBloc, ProductUserState>(
          builder: (context, state) {
            if (state is ProductUserInitial) {
              context.read<ProductUserBloc>().add(ProductUser());
            } else if (state is ProductUserLoading) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              height: 200.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.black45, width: 0.2),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(6.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 0.5,
                                    blurRadius: 1,
                                    offset: const Offset(1, 2),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        Expanded(
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              height: 200.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.black45, width: 0.2),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(6.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 0.5,
                                    blurRadius: 1,
                                    offset: const Offset(1, 2),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              height: 200.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.black45, width: 0.2),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(6.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 0.5,
                                    blurRadius: 1,
                                    offset: const Offset(1, 2),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        Expanded(
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            child: Container(
                              height: 200.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.black45, width: 0.2),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(6.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 0.5,
                                    blurRadius: 1,
                                    offset: const Offset(1, 2),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            } else if (state is ProductUserLoaded) {
              List<ProductUserRent> products = state.product;
              if (products.isEmpty) {
                return const Center(child: Text("Tidak ada hasil ditemukan."));
              }
              return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CardDetailProductUser(costum: products));
            }
            return Container(
              child: Center(child: Text("Tidak ada hasil ditemukan.")),
            );
          },
        ),
      ),
    );
  }
}
