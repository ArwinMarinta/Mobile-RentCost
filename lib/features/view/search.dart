import 'package:rentcost/features/model/costum.dart';
import 'package:rentcost/features/view/home.dart';
import 'package:rentcost/features/view/navigation_bar.dart';
import 'package:rentcost/features/widget/card_costum_search.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final List<Costum> costum = costumList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  context.go("/");
                },
                child: const SizedBox(
                    child: Icon(
                  FontAwesome.chevron_left_solid,
                  // Bootstrap.chevron_left,
                  size: 30.0,
                )),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Cari Kostum...",
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      borderSide: BorderSide(color: Colors.white, width: 0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0), // Mengatur border saat fokus
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0), // Mengatur border saat tidak fokus
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 12.0),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Jumlah kolom
          crossAxisSpacing: 15.0, // Jarak antar kolom
          mainAxisSpacing: 15.0, // Jarak antar baris
          childAspectRatio: 0.70, // Rasio untuk lebar vs tinggi item
        ),
        itemCount: costum.length,
        itemBuilder: (context, index) {
          // Kirim data Costum ke widget CardCostumTenant
          return CardCostumSearch(costum: costum[index]);
        },
      ),
      // bottomNavigationBar: const CustomNavigationBar(selectedIndex: 100),
    );
  }
}
