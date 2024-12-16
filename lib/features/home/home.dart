import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcost/features/banner/bloc/banner_bloc.dart';
import 'package:rentcost/features/banner/bloc/banner_event.dart';
import 'package:rentcost/features/banner/bloc/banner_state.dart';
import 'package:rentcost/features/category/bloc/category_bloc.dart';
import 'package:rentcost/features/category/bloc/category_event.dart';
import 'package:rentcost/features/category/bloc/category_state.dart';
import 'package:rentcost/features/home/Skleton.dart';
import 'package:rentcost/features/product/bloc/product_bloc.dart';
import 'package:rentcost/features/product/bloc/product_event.dart';
import 'package:rentcost/features/product/bloc/product_state.dart';
import 'package:rentcost/features/product/model/product.dart';
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
// import 'package:RentCost/features/model/category.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    context.read<UserBloc>().add(UserRequest());
    context.read<BannerBloc>().add(BannerRequest());
    context.read<CategoriesBloc>().add(CategoriesRequest());
    context.read<ProductBloc>().add(ProductFilter());
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserInitial) {
              context.read<UserBloc>().add(UserRequest());
            } else if (state is UserLoading) {
              return HomeSkleton();
            } else if (state is UserLoaded) {
              return AppBar(
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
                                image: NetworkImage(state
                                    .data.data.auth.user.imageUrl
                                    .toString()),
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
                              "Hai, ${state.data.data.auth.user.username}",
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
                              if (state.data.data.store == null) {
                                showCupertinoDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CupertinoAlertDialog(
                                      title: Text('Tidak ada Store'),
                                      content: Text(
                                          'Anda belum memiliki store. Anda dapat membuat store terlebih dahulu.'),
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
                                            'Buat Store',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          onPressed: () {
                                            context.go('/create-store');
                                            Navigator.of(context)
                                                .pop(); // Menutup dialog
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                context.go('/shop');
                              }
                            },
                            child: const Icon(Bootstrap.shop))
                      ],
                    )
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _onRefresh(context),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              BlocBuilder<BannerBloc, BannerState>(
                builder: (context, state) {
                  if (state is BannerInitial) {
                    context.read<BannerBloc>().add(BannerRequest());
                  }
                  if (state is BannerLoading) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: double.infinity,
                        height: 200.0,
                        color: Colors.grey,
                      ),
                    );
                  } else if (state is BannerLoaded) {
                    List<String> imagePaths = state.banner.map((bannerData) {
                      return bannerData.imageUrl;
                    }).toList();
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
              BlocBuilder<CategoriesBloc, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesInitial) {
                    context.read<CategoriesBloc>().add(CategoriesRequest());
                  } else if (state is CategoriesLoading) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(6.0)),
                                ),
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(6.0)),
                                ),
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(6.0)),
                                ),
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(6.0)),
                                ),
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(6.0)),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(6.0)),
                                ),
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(6.0)),
                                ),
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(6.0)),
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(6.0)),
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(6.0)),
                                  width: 60,
                                  height: 60.0,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  } else if (state is CategoriesLoaded) {
                    List<String> imagePaths = state.categories.map((data) {
                      return data.image_url;
                    }).toList();
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // Garis di kiri
                              Expanded(
                                child: Divider(
                                  // color: Color(0xFF881FFF),
                                  thickness: 2.0,
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
                                  thickness: 2.0, // Ketebalan garis
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 18.0,
                          ),
                          CarouselCategory(imagePaths: imagePaths),
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductInitial) {
                    context.read<ProductBloc>().add(ProductFilter());
                  } else if (state is ProductLoading) {
                    return SizedBox(
                      height: 285.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3, // Jumlah shimmer card
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                width: 150.0,
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
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 6.0, vertical: 5.0),
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Placeholder untuk nama produk
                                          Container(
                                            height: 16.0,
                                            width: 100.0,
                                            color: Colors.grey.shade400,
                                          ),
                                          const SizedBox(height: 4.0),
                                          // Placeholder untuk harga
                                          Container(
                                            height: 14.0,
                                            width: 80.0,
                                            color: Colors.grey.shade400,
                                          ),
                                          const SizedBox(height: 4.0),
                                          // Placeholder untuk lokasi
                                          Row(
                                            children: [
                                              Container(
                                                height: 13.0,
                                                width: 13.0,
                                                color: Colors.grey.shade400,
                                              ),
                                              const SizedBox(width: 4.0),
                                              Container(
                                                height: 14.0,
                                                width: 70.0,
                                                color: Colors.grey.shade400,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4.0),
                                          // Placeholder untuk rating dan jumlah tersewa
                                          Row(
                                            children: [
                                              Container(
                                                height: 13.0,
                                                width: 13.0,
                                                color: Colors.grey.shade400,
                                              ),
                                              const SizedBox(width: 4.0),
                                              Container(
                                                height: 14.0,
                                                width: 90.0,
                                                color: Colors.grey.shade400,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is ProductFilters) {
                    List<ProductData> costum = state.populer;
                    print(costum);
                    return Container(
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
                              ],
                            ),
                            const SizedBox(
                              height: 18.0,
                            ),
                            CardCostum(costum: costum),
                          ],
                        ));
                  }
                  return Container();
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductInitial) {
                    context.read<ProductBloc>().add(ProductFilter());
                  } else if (state is ProductLoading) {
                    return SizedBox(
                      height: 285.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3, // Jumlah shimmer card
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                width: 150.0,
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
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 6.0, vertical: 5.0),
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Placeholder untuk nama produk
                                          Container(
                                            height: 16.0,
                                            width: 100.0,
                                            color: Colors.grey.shade400,
                                          ),
                                          const SizedBox(height: 4.0),
                                          // Placeholder untuk harga
                                          Container(
                                            height: 14.0,
                                            width: 80.0,
                                            color: Colors.grey.shade400,
                                          ),
                                          const SizedBox(height: 4.0),
                                          // Placeholder untuk lokasi
                                          Row(
                                            children: [
                                              Container(
                                                height: 13.0,
                                                width: 13.0,
                                                color: Colors.grey.shade400,
                                              ),
                                              const SizedBox(width: 4.0),
                                              Container(
                                                height: 14.0,
                                                width: 70.0,
                                                color: Colors.grey.shade400,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4.0),
                                          // Placeholder untuk rating dan jumlah tersewa
                                          Row(
                                            children: [
                                              Container(
                                                height: 13.0,
                                                width: 13.0,
                                                color: Colors.grey.shade400,
                                              ),
                                              const SizedBox(width: 4.0),
                                              Container(
                                                height: 14.0,
                                                width: 90.0,
                                                color: Colors.grey.shade400,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is ProductFilters) {
                    List<ProductData> costum = state.news;
                    return Container(
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
                            ],
                          ),
                          const SizedBox(
                            height: 18.0,
                          ),
                          CardCostum(costum: costum)
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
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
}
