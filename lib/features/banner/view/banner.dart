import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:rentcost/features/banner/bloc/banner_bloc.dart';
import 'package:rentcost/features/banner/bloc/banner_event.dart';
import 'package:rentcost/features/banner/bloc/banner_state.dart';

class Banners extends StatelessWidget {
  const Banners({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<BannerBloc, BannerState>(
      listener: (context, state) {
        if (state is BannerDeleteLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is BannerDeleteSuccess) {
          Navigator.of(context).pop(); // Close loading dialog
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
          // context.read<BannerBloc>().add(BannerRequest());
        } else if (state is BannerDeleteFailure) {
          Navigator.of(context).pop(); // Menutup dialog jika terjadi error
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
                fontWeight: FontWeight.bold,
              ),
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
            if (state is BannerInitial) {
              context.read<BannerBloc>().add(BannerRequest());
            } else if (state is BannerLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BannerLoaded) {
              return ListView.builder(
                itemCount: state.banner.length,
                itemBuilder: (context, index) {
                  final banner = state.banner[index];

                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
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
                                banner.imageUrl,
                                fit: BoxFit.cover,
                                height: 100.0,
                                width: 100.0,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              banner.bannerName,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            // GestureDetector(
                            //   onTap: () {
                            //     // Implementasi untuk Ubah
                            //   },
                            //   child: const Text(
                            //     "Ubah",
                            //     style: TextStyle(color: Color(0xFFFFBE05)),
                            //   ),
                            // ),
                            const SizedBox(width: 12.0),
                            GestureDetector(
                              onTap: () {
                                showCupertinoDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CupertinoAlertDialog(
                                      title: const Text("Hapus Banner"),
                                      content: const Text(
                                          "Apakah Anda yakin ingin menghapus banner ini?"),
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
                                            context.read<BannerBloc>().add(
                                                BannerDeleteEvent(
                                                    id: banner
                                                        .id)); // Menutup dialog
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text(
                                "Hapus",
                                style: TextStyle(color: Color(0xFFFE8A8A)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
