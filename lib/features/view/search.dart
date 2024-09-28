import 'package:RentCost/features/view/home.dart';
import 'package:RentCost/features/view/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Container(
            //   margin: const EdgeInsets.symmetric(horizontal: 16.0),
            //   child: Row(
            //     children: [
            //       GestureDetector(
            //         onTap: null,
            //         child: Container(
            //             color: Colors.red,
            //             // margin: const EdgeInsets.symmetric(
            //             //     vertical: 10.0, horizontal: 8.0),
            //             padding: const EdgeInsets.all(10.0),
            //             child: const Icon(
            //               Bootstrap.chevron_left,
            //               size: 25.0,
            //             )),
            //       ),
            //       const Expanded(
            //         child: TextField(
            //           decoration: InputDecoration(
            //             hintText: "Cari Kostum...",
            //             filled: true,
            //             fillColor: Colors.grey,
            //             border: OutlineInputBorder(
            //               borderRadius: BorderRadius.all(Radius.circular(4.0)),
            //               borderSide: BorderSide(color: Colors.grey, width: 0),
            //             ),
            //             focusedBorder: OutlineInputBorder(
            //               borderRadius: BorderRadius.all(Radius.circular(4.0)),
            //               borderSide: BorderSide(
            //                   color: Colors.grey,
            //                   width: 1.0), // Mengatur border saat fokus
            //             ),
            //             enabledBorder: OutlineInputBorder(
            //               borderRadius: BorderRadius.all(Radius.circular(4.0)),
            //               borderSide: BorderSide(
            //                   color: Colors.grey,
            //                   width: 1.0), // Mengatur border saat tidak fokus
            //             ),
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            Container(),
            Container(),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(selectedIndex: 100),
    );
  }
}
