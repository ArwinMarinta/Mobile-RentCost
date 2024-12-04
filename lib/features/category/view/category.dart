import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:rentcost/features/category/bloc/category_bloc.dart';
import 'package:rentcost/features/category/bloc/category_event.dart';
import 'package:rentcost/features/category/bloc/category_state.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
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
              "Kategori Costume",
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
                  // Mengambil data BannerData
                  final categries = state.categories[index];

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
                                categries.image_url,
                                fit: BoxFit.cover,
                                height: 100.0,
                                width: 100.0,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              categries.category_name,
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
        ));
  }
}
