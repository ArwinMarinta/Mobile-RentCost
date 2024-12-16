import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:rentcost/features/category/bloc/category_bloc.dart';
import 'package:rentcost/features/category/bloc/category_event.dart';
import 'package:rentcost/features/category/bloc/category_state.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({super.key});

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  TextEditingController category_name = TextEditingController();
  String? showFileName = "";
  String errorMessage = '';
  int maxSizeInBytes = 3 * 1024 * 1024;
  FilePickerResult? filePickerResult;
  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoriesBloc, CategoriesState>(
      listener: (context, state) {
        if (state is CategoriesCreateLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is CategoriesCreateSuccess) {
          Navigator.of(context).pop();

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

          context.read<CategoriesBloc>().add(CategoriesRequest());
          context.go('/category');
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
                context.go("/category");
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
                  "Tambah Kategori",
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        child: Text(
                          "Nama Kategori",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        controller: category_name,
                        onChanged: null,
                        decoration: const InputDecoration(
                          hintText: 'Ex: Mobile Legend',
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
                          "Gambar Kategori",
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
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: GestureDetector(
            onTap: () {
              final categoryNameText = category_name.text.trim();

              if (categoryNameText.isEmpty) {
                setState(() {
                  errorMessage = 'Nama banner tidak boleh kosong';
                });
                return;
              }

              if (filePickerResult == null || filePickerResult!.files.isEmpty) {
                setState(() {
                  errorMessage = 'Pilih gambar untuk banner';
                });
                return;
              }

              setState(() {
                errorMessage = '';
              });

              if (filePickerResult != null &&
                  filePickerResult!.files.isNotEmpty) {
                context.read<CategoriesBloc>().add(CategoriesCreateEvent(
                    file: filePickerResult?.files.first.path ?? '',
                    category_name: categoryNameText));
              }
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF881FFF),
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Tambah',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
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
