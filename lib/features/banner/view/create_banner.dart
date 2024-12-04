import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:rentcost/features/banner/bloc/banner_bloc.dart';
import 'package:rentcost/features/banner/bloc/banner_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcost/features/banner/bloc/banner_state.dart';

class CreateBanner extends StatefulWidget {
  const CreateBanner({super.key});

  @override
  State<CreateBanner> createState() => _CreateBannerState();
}

class _CreateBannerState extends State<CreateBanner> {
  TextEditingController banner_name = TextEditingController();
  String? showFileName = "";
  String errorMessage = '';
  int maxSizeInBytes = 3 * 1024 * 1024; // 1 MB
  FilePickerResult? filePickerResult;

  @override
  void dispose() {
    banner_name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(filePickerResult);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            context.go("/banner");
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
            Padding(padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2)),
            Text(
              "Tambah Banner",
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BlocListener<BannerBloc, BannerState>(
            listener: (context, state) {
              if (state is BannerCreateLoading) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is BannerCreateSuccess) {
                showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                      content: Text('Berhasil menambah banner'),
                    );
                  },
                );

                Future.delayed(Duration(seconds: 3), () {
                  Navigator.of(context).pop();
                  context.go('/');
                });
              }
            },
            child: Column(
              children: <Widget>[
                // Nama Banner
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        child: Text(
                          "Nama Banner",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        controller: banner_name,
                        decoration: const InputDecoration(
                          hintText: 'Nama Banner',
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
                                color: Color(0xFF881FFF), width: 2.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                // Upload Gambar Banner
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        child: Text(
                          "Gambar Banner",
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
                                              setState(() {
                                                showFileName = file.name;
                                                errorMessage = '';
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
                                            // Memeriksa apakah file telah dipilih dan menampilkan nama file
                                            filePickerResult != null &&
                                                    filePickerResult!
                                                        .files.isNotEmpty
                                                ? filePickerResult!.files.first
                                                    .name // Nama file pertama
                                                : 'Belum ada file yang dipilih', // Jika belum ada file yang dipilih
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (errorMessage.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        errorMessage,
                                        style: TextStyle(color: Colors.red),
                                      ),
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
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: GestureDetector(
          onTap: () {
            final bannerNameText = banner_name.text.trim();

            if (bannerNameText.isEmpty) {
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
              context.read<BannerBloc>().add(
                    BannerCreateEvent(
                      file: filePickerResult?.files.first.path ?? '',
                      banner_name: bannerNameText,
                    ),
                  );
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
    );
  }
}
