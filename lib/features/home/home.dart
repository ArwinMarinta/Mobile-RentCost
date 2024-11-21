import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcost/features/banner/bloc/banner_bloc.dart';
import 'package:rentcost/features/banner/bloc/banner_event.dart';
import 'package:rentcost/features/banner/bloc/banner_state.dart';
import 'package:rentcost/features/model/costum.dart';
import 'package:rentcost/features/users/bloc/user_bloc.dart';
import 'package:rentcost/features/users/bloc/user_event.dart';
import 'package:rentcost/features/users/bloc/user_state.dart';
import 'package:rentcost/features/widget/card_costum.dart';
// import 'package:rentcost/features/widget/carousel_card.dart';
import 'package:rentcost/features/widget/carousel_category.dart';
import "package:flutter/material.dart";
import 'package:rentcost/features/view/navigation_bar.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:rentcost/features/widget/carousel_banner.dart';
import 'package:rentcost/features/model/category.dart';
// import 'package:RentCost/features/model/category.dart';
import 'package:go_router/go_router.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(UserRequest());
    context.read<BannerBloc>().add(BannerRequest());
  }

  @override
  Widget build(BuildContext context) {
    List<String> imagePaths =
        categoryList.map((category) => category.path).toList();
    final List<Costum> costum = costumList;
    final List<Costum> costum1 = costumNewList;
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserLoading) {
        return Scaffold(
          body: Center(
              child:
                  CircularProgressIndicator()), // Menampilkan indikator loading
        );
      } else if (state is UserLoaded) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: AppBar(
              scrolledUnderElevation: 0.0,
              backgroundColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.go('/profile');
                        },
                        child: Container(
                          width: 35.0,
                          height: 35.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xFF881FFF), width: 1.0),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                  state.data.first.data.user.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hai, ${state.data.first.data.user.username}",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "Temukan kostum favoritmu...",
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.go("/search");
                        },
                        child: const Icon(FontAwesome.magnifying_glass_solid),
                      ),
                      const SizedBox(width: 15.0),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              context.go('/shop');
                            });
                          },
                          child: const Icon(Bootstrap.shop))
                    ],
                  )
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                BlocBuilder<BannerBloc, BannerState>(
                  builder: (context, state) {
                    if (state is BannerLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is BannerLoaded) {
                      List<String> imagePaths = state.banner.map((bannerData) {
                        return bannerData.imageUrl;
                      }).toList();
                      print(imagePaths);

                      return SizedBox(
                        child: CarouselBanner(imagePaths: imagePaths),
                      );
                    }
                    return Container();
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Garis di kiri
                          Expanded(
                            child: Divider(
                              // color: Color(0xFF881FFF), // Warna garis
                              thickness: 2.0, // Ketebalan garis
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Text(
                            "Kategori Cosplay",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Divider(
                              // color: Color(0xFF881FFF), // Warna garis
                              thickness: 2.0, // Ketebalan garis
                            ),
                          ),
                          // GestureDetector(
                          //   onTap: () {
                          //     context.go('/category');
                          //   },
                          //   child: const Row(
                          //     crossAxisAlignment: CrossAxisAlignment.center,
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Text(
                          //         "Lihat Semua",
                          //         style: TextStyle(
                          //             fontSize: 13.0, color: Color(0xFF881FFF)),
                          //       ),
                          //       Icon(
                          //         Bootstrap.chevron_right,
                          //         size: 11.0,
                          //         weight: 10.0,
                          //         color: Color(0xFF881FFF),
                          //       )
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                      const SizedBox(
                        height: 18.0,
                      ),
                      CarouselCategory(imagePaths: imagePaths),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Kostum Terpopuler",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // GestureDetector(
                            //   child: const Row(
                            //     crossAxisAlignment: CrossAxisAlignment.center,
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: [
                            //       Text(
                            //         "Lihat Semua",
                            //         style: TextStyle(
                            //             fontSize: 13.0, color: Color(0xFF881FFF)),
                            //       ),
                            //       Icon(
                            //         Bootstrap.chevron_right,
                            //         size: 11.0,
                            //         weight: 10.0,
                            //         color: Color(0xFF881FFF),
                            //       )
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                        const SizedBox(
                          height: 18.0,
                        ),
                        CardCostum(costum: costum),
                      ],
                    )),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Kostum Terbaru",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // GestureDetector(
                          //   child: const Row(
                          //     crossAxisAlignment: CrossAxisAlignment.center,
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Text(
                          //         "Lihat Semua",
                          //         style: TextStyle(
                          //             fontSize: 13.0, color: Color(0xFF881FFF)),
                          //       ),
                          //       Icon(
                          //         Bootstrap.chevron_right,
                          //         size: 11.0,
                          //         weight: 10.0,
                          //         color: Color(0xFF881FFF),
                          //       )
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                      const SizedBox(
                        height: 18.0,
                      ),
                      CardCostum(costum: costum1)
                    ],
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: Container(
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
              ),
              child: const CustomNavigationBar(selectedIndex: 0)),
        );
      }
      return Container();
    });
  }
}
