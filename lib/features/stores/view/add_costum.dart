import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:rentcost/features/stores/bloc/stores_bloc.dart';
import 'package:rentcost/features/stores/bloc/stores_event.dart';
import 'package:rentcost/features/stores/bloc/stores_state.dart';

class AddCostum extends StatefulWidget {
  const AddCostum({super.key});

  @override
  State<AddCostum> createState() => _AddCostumState();
}

class _AddCostumState extends State<AddCostum> {
  TextEditingController productName = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController imageUrl = TextEditingController();
  TextEditingController categoryId = TextEditingController();
  TextEditingController size_stock = TextEditingController();
  List<Map<String, dynamic>> sizeStock = [];

  String? showFileName = "";
  String errorMessage = '';
  int maxSizeInBytes = 1 * 1024 * 1024;
  FilePickerResult? filePickerResult;

  void _addStock() {
    setState(() {
      sizeStock.add({
        'size': '', // Placeholder untuk size
        'stock': '', // Placeholder untuk stock
      });
    });
  }

  void _updateStock(int index, String type, String value) {
    setState(() {
      sizeStock[index][type] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StoreBloc, StoreState>(
      listener: (context, state) {
        if (state is ProductLoadingStore) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is ProductSuccessStore) {
          Navigator.of(context).pop(); // Close loading dialog
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

          Future.delayed(const Duration(seconds: 3), () {
            context.go('/store');
          });
        } else if (state is ProductFailureStore) {
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
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2)),
                Text(
                  "Tambah Costum",
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )),
        body: SingleChildScrollView(
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        child: Text(
                          "Nama Costum",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        controller: productName,
                        onChanged: null,
                        decoration: const InputDecoration(
                          hintText: 'Nama Costum',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF8E8E8E), width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                            borderSide: BorderSide(
                                color: Color(0xFF881FFF),
                                width: 2.0), // Mengatur border saat fokus
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        child: Text(
                          "Harga",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        controller: price,
                        onChanged: null,
                        decoration: const InputDecoration(
                          hintText: 'Harga',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF8E8E8E), width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                            borderSide: BorderSide(
                                color: Color(0xFF881FFF),
                                width: 2.0), // Mengatur border saat fokus
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                // Container(
                //   child: Column(
                //     // mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       const SizedBox(
                //         child: Text(
                //           "Stok",
                //           style: TextStyle(
                //               fontSize: 16.0, fontWeight: FontWeight.w500),
                //         ),
                //       ),
                //       const SizedBox(
                //         height: 8.0,
                //       ),
                //       TextField(
                //         onChanged: null,
                //         decoration: const InputDecoration(
                //           hintText: 'ex: 1',
                //           contentPadding: EdgeInsets.symmetric(
                //               vertical: 10.0, horizontal: 20.0),
                //           border: OutlineInputBorder(
                //             borderRadius:
                //                 BorderRadius.all(Radius.circular(6.0)),
                //           ),
                //           enabledBorder: OutlineInputBorder(
                //             borderSide: BorderSide(
                //                 color: Color(0xFF8E8E8E), width: 1.0),
                //             borderRadius:
                //                 BorderRadius.all(Radius.circular(6.0)),
                //           ),
                //           focusedBorder: OutlineInputBorder(
                //             borderRadius:
                //                 BorderRadius.all(Radius.circular(6.0)),
                //             borderSide: BorderSide(
                //                 color: Color(0xFF881FFF),
                //                 width: 2.0), // Mengatur border saat fokus
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // const SizedBox(
                //   height: 20.0,
                // ),
                Container(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        child: Text(
                          "Category",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        controller: categoryId,
                        onChanged: null,
                        decoration: const InputDecoration(
                          hintText: 'ex: 1',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF8E8E8E), width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                            borderSide: BorderSide(
                                color: Color(0xFF881FFF),
                                width: 2.0), // Mengatur border saat fokus
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                // Container(
                //   child: Column(
                //     // mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       const SizedBox(
                //         child: Text(
                //           "Size",
                //           style: TextStyle(
                //               fontSize: 16.0, fontWeight: FontWeight.w500),
                //         ),
                //       ),
                //       const SizedBox(
                //         height: 8.0,
                //       ),
                //       TextField(
                //         onChanged: null,
                //         decoration: const InputDecoration(
                //           hintText: 'ex: M',
                //           contentPadding: EdgeInsets.symmetric(
                //               vertical: 10.0, horizontal: 20.0),
                //           border: OutlineInputBorder(
                //             borderRadius:
                //                 BorderRadius.all(Radius.circular(6.0)),
                //           ),
                //           enabledBorder: OutlineInputBorder(
                //             borderSide: BorderSide(
                //                 color: Color(0xFF8E8E8E), width: 1.0),
                //             borderRadius:
                //                 BorderRadius.all(Radius.circular(6.0)),
                //           ),
                //           focusedBorder: OutlineInputBorder(
                //             borderRadius:
                //                 BorderRadius.all(Radius.circular(6.0)),
                //             borderSide: BorderSide(
                //                 color: Color(0xFF881FFF),
                //                 width: 2.0), // Mengatur border saat fokus
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // const SizedBox(
                //   height: 20.0,
                // ),
                Container(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        child: Text(
                          "Gambar Costum",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)),
                                border:
                                    Border.all(color: Colors.black, width: 0.5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          filePickerResult = await FilePicker
                                              .platform
                                              .pickFiles(
                                            type: FileType.custom,
                                            allowedExtensions: [
                                              'jpeg',
                                              'jpg',
                                              'png'
                                            ],
                                          );

                                          if (filePickerResult != null) {
                                            var file =
                                                filePickerResult!.files.first;
                                            if (file.size > maxSizeInBytes) {
                                              setState(() {
                                                errorMessage =
                                                    'Ukuran file tidak boleh lebih dari 1 MB';
                                                showFileName = '';
                                              });
                                            } else {
                                              // Jika ukuran file sesuai, perbarui state dengan nama file
                                              setState(() {
                                                showFileName = file.name;
                                                errorMessage =
                                                    ''; // Clear any previous error message
                                              });
                                            }
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 14.0, horizontal: 8.0),
                                          backgroundColor:
                                              const Color(0xFF881FFF),
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.0)),
                                          ),
                                        ),
                                        child: const Text(
                                          'Pilih File',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            showFileName!,
                                            overflow: TextOverflow.ellipsis,
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
                const SizedBox(
                  height: 20.0,
                ),
                // Container(
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Container(
                //           child: Column(
                //             // mainAxisAlignment: MainAxisAlignment.start,
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               const SizedBox(
                //                 child: Text(
                //                   "Size",
                //                   style: TextStyle(
                //                       fontSize: 16.0,
                //                       fontWeight: FontWeight.w500),
                //                 ),
                //               ),
                //               const SizedBox(
                //                 height: 8.0,
                //               ),
                //               TextField(
                //                 onChanged: null,
                //                 decoration: const InputDecoration(
                //                   hintText: 'ex: M',
                //                   contentPadding: EdgeInsets.symmetric(
                //                       vertical: 10.0, horizontal: 20.0),
                //                   border: OutlineInputBorder(
                //                     borderRadius:
                //                         BorderRadius.all(Radius.circular(6.0)),
                //                   ),
                //                   enabledBorder: OutlineInputBorder(
                //                     borderSide: BorderSide(
                //                         color: Color(0xFF8E8E8E), width: 1.0),
                //                     borderRadius:
                //                         BorderRadius.all(Radius.circular(6.0)),
                //                   ),
                //                   focusedBorder: OutlineInputBorder(
                //                     borderRadius:
                //                         BorderRadius.all(Radius.circular(6.0)),
                //                     borderSide: BorderSide(
                //                         color: Color(0xFF881FFF),
                //                         width:
                //                             2.0), // Mengatur border saat fokus
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //       const SizedBox(
                //         width: 20,
                //       ),
                //       Expanded(
                //         child: Container(
                //           child: Column(
                //             // mainAxisAlignment: MainAxisAlignment.start,
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               const SizedBox(
                //                 child: Text(
                //                   "Stok",
                //                   style: TextStyle(
                //                       fontSize: 16.0,
                //                       fontWeight: FontWeight.w500),
                //                 ),
                //               ),
                //               const SizedBox(
                //                 height: 8.0,
                //               ),
                //               TextField(
                //                 onChanged: null,
                //                 decoration: const InputDecoration(
                //                   hintText: 'ex: 1',
                //                   contentPadding: EdgeInsets.symmetric(
                //                       vertical: 10.0, horizontal: 20.0),
                //                   border: OutlineInputBorder(
                //                     borderRadius:
                //                         BorderRadius.all(Radius.circular(6.0)),
                //                   ),
                //                   enabledBorder: OutlineInputBorder(
                //                     borderSide: BorderSide(
                //                         color: Color(0xFF8E8E8E), width: 1.0),
                //                     borderRadius:
                //                         BorderRadius.all(Radius.circular(6.0)),
                //                   ),
                //                   focusedBorder: OutlineInputBorder(
                //                     borderRadius:
                //                         BorderRadius.all(Radius.circular(6.0)),
                //                     borderSide: BorderSide(
                //                         color: Color(0xFF881FFF),
                //                         width:
                //                             2.0), // Mengatur border saat fokus
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                // GestureDetector(
                //   onTap: null,
                //   child: Row(children: [
                //     Icon(
                //       Bootstrap.plus_circle,
                //       size: 20,
                //     ),
                //     const SizedBox(
                //       width: 6.0,
                //     ),
                //     Text("Tambah Stock")
                //   ]),
                // )
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...sizeStock.map((stock) {
                        int index = sizeStock.indexOf(stock);
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Row(
                            children: [
                              // Size Input
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      child: Text(
                                        "Size",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    TextField(
                                      onChanged: (value) =>
                                          _updateStock(index, 'size', value),
                                      decoration: const InputDecoration(
                                        hintText: 'ex: M',
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 20.0),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6.0)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF8E8E8E),
                                              width: 1.0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6.0)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6.0)),
                                          borderSide: BorderSide(
                                              color: Color(0xFF881FFF),
                                              width: 2.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 20),
                              // Stock Input
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      child: Text(
                                        "Stok",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    TextField(
                                      onChanged: (value) =>
                                          _updateStock(index, 'stock', value),
                                      decoration: const InputDecoration(
                                        hintText: 'ex: 1',
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 20.0),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6.0)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF8E8E8E),
                                              width: 1.0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6.0)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6.0)),
                                          borderSide: BorderSide(
                                              color: Color(0xFF881FFF),
                                              width: 2.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: _addStock,
                        child: Row(
                          children: [
                            Icon(
                              Icons.add_circle, // Digunakan untuk icon tambah
                              size: 20,
                            ),
                            const SizedBox(width: 6.0),
                            Text("Buat atau tambah stock")
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: SizedBox(
            // padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GestureDetector(
              onTap: null,
              child: Container(
                decoration: const BoxDecoration(
                    color: Color(0xFF881FFF),
                    borderRadius: BorderRadius.all(Radius.circular(6.0))),
                // padding: const EdgeInsets.all(16.0),
                child: const Center(
                  child: Text(
                    'Tambah',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.white),
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
