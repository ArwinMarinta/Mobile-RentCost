import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:rentcost/features/category/bloc/category_bloc.dart';
import 'package:rentcost/features/category/bloc/category_event.dart';
import 'package:rentcost/features/category/bloc/category_state.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoriesBloc, CategoriesState>(
      listener: (context, state) {
        if (state is CategoriesDeleteLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is CategoriesDeleteSuccess) {
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            ),
          );

          context.read<CategoriesBloc>().add(CategoriesRequest());
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
              "Kategori Costume",
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
                  context.go('/add-category');
                },
                child: const Icon(Bootstrap.plus_circle),
              ),
            ),
          ],
        ),
        body: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
            if (state is CategoriesInitial) {
              context.read<CategoriesBloc>().add(CategoriesRequest());
            } else if (state is CategoriesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CategoriesLoaded) {
              return ListView.builder(
                itemCount: state.categories.length,
                itemBuilder: (context, index) {
                  final category = state.categories[index];

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
                              borderRadius: const BorderRadius.all(
                                Radius.circular(6.0),
                              ),
                              child: Image.network(
                                category.image_url,
                                fit: BoxFit.cover,
                                height: 100.0,
                                width: 100.0,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              category.category_name,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Implementasi untuk Ubah
                              },
                              child: const Text(
                                "Ubah",
                                style: TextStyle(color: Color(0xFFFFBE05)),
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            GestureDetector(
                              onTap: () {
                                showCupertinoDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CupertinoAlertDialog(
                                      title: const Text("Hapus Categories"),
                                      content: const Text(
                                          "Apakah Anda yakin ingin menghapus categories ini?"),
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
                                            context.read<CategoriesBloc>().add(
                                                CategoriesDeleteEvent(
                                                    id: category
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
