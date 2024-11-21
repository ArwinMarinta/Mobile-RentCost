import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:rentcost/features/banner/bloc/banner_bloc.dart';
import 'package:rentcost/features/banner/bloc/banner_event.dart';
import 'package:rentcost/features/banner/bloc/banner_state.dart';
import 'package:rentcost/features/users/bloc/user_bloc.dart';
import 'package:rentcost/features/users/bloc/user_event.dart';

class Banners extends StatefulWidget {
  const Banners({super.key});

  @override
  State<Banners> createState() => _BannersState();
}

class _BannersState extends State<Banners> {
  @override
  void initState() {
    super.initState();
    context.read<BannerBloc>().add(BannerRequest());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            context.go('/profile');
          },
          child: const Icon(
            FontAwesome.chevron_left_solid,
            color: Colors.black,
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            "Banner",
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: GestureDetector(
              onTap: () {
                context.go('/add-banner');
              },
              child: const Icon(Bootstrap.plus_circle),
            ),
          ),
        ],
      ),
      body: BlocBuilder<BannerBloc, BannerState>(
        builder: (context, state) {
          if (state is BannerLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BannerLoaded) {
            print('bdhjdhwd');
            // Menggunakan ListView untuk menampilkan daftar banner
            return ListView.builder(
              itemCount: state.banner.length,
              itemBuilder: (context, index) {
                // Mengambil data BannerData
                final banner = state.banner[index];

                return Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black, width: 0.2),
                      top: BorderSide(color: Colors.black, width: 0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6.0)),
                            child: Image.network(
                              banner
                                  .imageUrl, // Menggunakan imageUrl dari BannerData
                              fit: BoxFit.cover,
                              height: 100.0,
                              width: 100.0,
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Text(
                            banner
                                .bannerName, // Menggunakan bannerName dari BannerData
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Implementasi untuk Ubah
                            },
                            child: Text(
                              "Ubah",
                              style: TextStyle(color: Color(0xFFFFBE05)),
                            ),
                          ),
                          const SizedBox(width: 12.0),
                          GestureDetector(
                            onTap: () {
                              // Implementasi untuk Hapus
                            },
                            child: Text(
                              "Hapus",
                              style: TextStyle(color: Color(0xFFFE8A8A)),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
