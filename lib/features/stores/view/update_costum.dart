import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:rentcost/features/category/bloc/category_bloc.dart';
import 'package:rentcost/features/category/bloc/category_state.dart';
import 'package:rentcost/features/product/bloc/detail_bloc.dart';
import 'package:rentcost/features/product/bloc/detail_event.dart';
import 'package:rentcost/features/product/bloc/detail_state.dart';
import 'package:rentcost/features/product/bloc/product_bloc.dart';
import 'package:rentcost/features/product/bloc/product_state.dart';
import 'package:rentcost/features/stores/bloc/stores_bloc.dart';
import 'package:rentcost/features/stores/bloc/stores_event.dart';
import 'package:rentcost/features/stores/bloc/stores_state.dart';
import 'package:rentcost/features/users/bloc/user_product_bloc.dart';
import 'package:rentcost/features/users/bloc/user_product_event.dart';

class UpdateCostum extends StatefulWidget {
  final String id;
  const UpdateCostum({required this.id, super.key});

  @override
  State<UpdateCostum> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<UpdateCostum> {
  TextEditingController productName = TextEditingController();
  TextEditingController price = TextEditingController();

  String? productNames;
  String? prices;
  String? imageUrl;
  int? oldCategoriId;
  String? oldCategoriName;

  int? categoryId;
  String? categoryName;

  late String currentId;

  String? showFileName = "";
  String errorMessage = '';
  int maxSizeInBytes = 1 * 1024 * 1024;
  FilePickerResult? filePickerResult;

  @override
  void initState() {
    super.initState();
    currentId = widget.id;
    BlocProvider.of<DetailBloc>(context).add(DetailProduct(id: currentId));
  }

  @override
  Widget build(BuildContext context) {
    print(categoryId);
    return BlocListener<StoreBloc, StoreState>(
      listener: (context, state) {
        if (state is ProductUpdateLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is ProductUpdateSuccess) {
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

          context.read<DetailBloc>().add(DetailProduct(id: currentId));
          context.read<ProductUserBloc>().add(ProductUser());
          context.go("/detail/user/${currentId}");
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
                context.go("/detail/user/${currentId}");
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
                  "Ubah Costum",
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )),
        body: BlocBuilder<DetailBloc, DetailState>(
          builder: (context, state) {
            if (state is DetailProductState) {
              final data = state.detail.data;
              final category = 2;
              final name = "Genshin Impacts";
              productNames = data.productName;
              prices = data.price.toString();
              categoryId = category;
              imageUrl = data.imageUrl;
              oldCategoriName = name;

              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
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
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            TextField(
                              controller: productName
                                ..text = productNames ?? productName.text,
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
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            TextField(
                              controller: price..text = prices ?? price.text,
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xFF8E8E8E),
                                          width: 1.0),
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<int>(
                                        value: oldCategoriId,
                                        hint: Text(
                                            categoryName?.isNotEmpty == true
                                                ? categoryName!
                                                : oldCategoriName.toString()),
                                        items: state.categories.map((category) {
                                          return DropdownMenuItem<int>(
                                            value: category.id,
                                            child: Text(category.category_name),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            categoryId =
                                                value; // Update the selected category ID
                                            // Update the category name based on the selected ID
                                            var selectedCategory =
                                                state.categories.firstWhere(
                                              (category) =>
                                                  category.id == categoryId,
                                              orElse: () => state.categories
                                                  .first, // Menggunakan kategori pertama sebagai fallback
                                            );

                                            categoryName = selectedCategory
                                                .category_name; // Optional: Handle null case if no category found
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
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500),
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
                                      border: Border.all(
                                          color: Colors.black, width: 0.5),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                filePickerResult =
                                                    await FilePicker.platform
                                                        .pickFiles(
                                                  type: FileType.custom,
                                                  allowedExtensions: [
                                                    'jpeg',
                                                    'jpg',
                                                    'png'
                                                  ],
                                                );

                                                if (filePickerResult != null) {
                                                  var file = filePickerResult!
                                                      .files.first;
                                                  if (file.size >
                                                      maxSizeInBytes) {
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 14.0,
                                                        horizontal: 8.0),
                                                backgroundColor:
                                                    const Color(0xFF881FFF),
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  showFileName!.isEmpty
                                                      ? imageUrl.toString()
                                                      : showFileName!,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                    ],
                  ),
                ),
              );
            } else if (state is DetailFailure) {
              return Container(
                  child: Center(
                child: Text("Terjadi kesalahan"),
              ));
            }
            return Container(
                child: Center(
              child: Text("Loading..."),
            ));
          },
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: SizedBox(
            // padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GestureDetector(
              onTap: () {
                final productNameText = productName.text.trim().isEmpty
                    ? productNames
                    : productName.text.trim();

                final priceText =
                    price.text.trim().isEmpty ? prices : price.text.trim();

                final categoryIdText =
                    categoryId != null ? categoryId : oldCategoriId;

                final imageUrlText =
                    filePickerResult?.files.first.path ?? imageUrl;

                final oldImageText = imageUrl.toString();

                print(productNameText);
                print(priceText);
                print(categoryIdText);
                print(imageUrlText);

                context.read<StoreBloc>().add(ProductUpdateEvent(
                    productName: productNameText.toString(),
                    price: priceText.toString(),
                    imageUrl: imageUrlText.toString(),
                    categoryId: categoryIdText.toString(),
                    id: currentId,
                    oldImageUrl: oldImageText));
              },
              child: Container(
                decoration: const BoxDecoration(
                    color: Color(0xFF881FFF),
                    borderRadius: BorderRadius.all(Radius.circular(6.0))),
                // padding: const EdgeInsets.all(16.0),
                child: const Center(
                  child: Text(
                    'Update Kostum',
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
