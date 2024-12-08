import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:rentcost/features/category/bloc/category_bloc.dart';
import 'package:rentcost/features/category/bloc/category_state.dart';
import 'package:rentcost/features/category/model/category_model.dart';
import 'package:rentcost/features/stores/bloc/stores_bloc.dart';
import 'package:rentcost/features/stores/bloc/stores_event.dart';
import 'package:rentcost/features/stores/bloc/stores_state.dart';
import 'package:rentcost/features/users/bloc/user_product_bloc.dart';
import 'package:rentcost/features/users/bloc/user_product_event.dart';

class AddCostum extends StatefulWidget {
  const AddCostum({super.key});

  @override
  State<AddCostum> createState() => _AddCostumState();
}

class _AddCostumState extends State<AddCostum> {
  TextEditingController productName = TextEditingController();
  TextEditingController price = TextEditingController();
  int? categoryId;
  List<Map<String, dynamic>> sizeStock = [];

  String? showFileName = "";
  String errorMessage = '';
  int maxSizeInBytes = 1 * 1024 * 1024;
  FilePickerResult? filePickerResult;

  void _addStock() {
    setState(() {
      sizeStock.add({
        'size_id': '',
        'stok': '',
      });
    });
  }

  void _updateStock(int index, String type, String value) {
    setState(() {
      sizeStock[index][type] = value;
    });
  }

  void _deleteStock(int index) {
    setState(() {
      sizeStock.removeAt(index);
    });
  }

  Map<String, String> sizeMapping = {
    '1': 'S',
    '2': 'M',
    '3': 'L',
    '4': 'XL',
    '5': 'XXL',
  };

  @override
  Widget build(BuildContext context) {
    print(sizeStock);
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
            context.read<ProductUserBloc>().add(ProductUser());
            context.go('/shop');
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
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "Category",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      BlocBuilder<CategoriesBloc, CategoriesState>(
                        builder: (context, state) {
                          if (state is CategoriesLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is CategoriesLoaded) {
                            return Container(
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0xFF8E8E8E), width: 1.0),
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<int>(
                                  value: categoryId,
                                  hint: const Text('Select a category'),
                                  items: state.categories.map((category) {
                                    return DropdownMenuItem<int>(
                                      value: category.id,
                                      child: Text(category.category_name),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      categoryId = value;
                                      print(categoryId);
                                    });
                                  },
                                ),
                              ),
                            );
                          } else if (state is CategoriesFailure) {
                            return Text('Error: ${state.error}');
                          }
                          return const Text('No categories available.');
                        },
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
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...sizeStock.map((stock) {
                        int index = sizeStock.indexOf(stock);
                        // Dapatkan daftar ukuran yang sudah digunakan

                        String? selectedSize =
                            stock['size_id'] as String?; 

                        List<String> availableSizes = ['1', '2', '3', '4', '5']
                            .where((size) => !sizeStock
                                .where((s) =>
                                    s !=
                                    stock) 
                                .map((s) => s['size_id'] as String)
                                .contains(size))
                            .toList();

                        if (selectedSize != null &&
                            !availableSizes.contains(selectedSize)) {
                          availableSizes.add(
                              selectedSize); // Tambahkan ukuran yang dipilih
                        }

                        return Container(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                    DropdownButtonFormField<String>(
                                      items:
                                          availableSizes.map((String sizeId) {
                                        String displaySize = sizeMapping[
                                                sizeId] ??
                                            sizeId; // Ambil nama ukuran berdasarkan ID
                                        return DropdownMenuItem<String>(
                                          value: sizeId, // Kirim ID ke server
                                          child: Text(
                                              displaySize), // Tampilkan nama ukuran
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        if (value != null) {
                                          _updateStock(index, 'size_id',
                                              value);
                                        }
                                      },
                                      decoration: const InputDecoration(
                                        hintText: 'Select size',
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 10.0,
                                          horizontal: 20.0,
                                        ),
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
                                      hint: const Text("ex: M"),
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
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      onChanged: (value) =>
                                          _updateStock(index, 'stok', value),
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

                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: GestureDetector(
                                  onTap: () {
                                    _deleteStock(index);
                                  },
                                  child: Icon(
                                    Bootstrap.trash,
                                    color: Colors.red,
                                  ),
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
                            const Icon(
                              Icons.add_circle, // Digunakan untuk icon tambah
                              size: 20,
                            ),
                            const SizedBox(width: 6.0),
                            const Text("Buat atau tambah stock")
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: SizedBox(
            // padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GestureDetector(
              onTap: () {
                final productNameText = productName.text.trim();
                final priceText = price.text.trim();
                final categoryIdText = categoryId.toString();
                final sizeList = sizeStock.map((item) {
                  return {
                    'size_id': item['size_id'],
                    'stok': item['stok'],
                  };
                }).toList();

                context.read<StoreBloc>().add(ProductCreateEvent(
                    productName: productNameText,
                    price: priceText,
                    imageUrl: filePickerResult?.files.first.path ?? '',
                    categoryId: categoryIdText,
                    sizeStock: sizeList));
              },
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
