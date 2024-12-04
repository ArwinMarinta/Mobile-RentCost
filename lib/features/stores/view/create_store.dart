import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_state.dart';
import 'package:rentcost/features/stores/bloc/stores_bloc.dart';
import 'package:rentcost/features/stores/bloc/stores_event.dart';
import 'package:rentcost/features/stores/bloc/stores_state.dart';
import 'package:rentcost/features/users/bloc/user_bloc.dart';
import 'package:rentcost/features/users/bloc/user_event.dart';

class CreateStore extends StatefulWidget {
  const CreateStore({super.key});

  @override
  State<CreateStore> createState() => _CreateStoreState();
}

class _CreateStoreState extends State<CreateStore> {
  TextEditingController storeName = TextEditingController();
  TextEditingController locationName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            scrolledUnderElevation: 0.0,
            backgroundColor: Colors.white,
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                context.go("/");
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
                  "Create Store",
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
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            child: BlocListener<StoreBloc, StoreState>(
              listener: (context, state) {
                if (state is StoreLoading) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is StoreSuccess) {
                  Navigator.of(context).pop();
                  context.go('/select_address');
                  context.read<UserBloc>().add(UserRequest());
                } else if (state is StoreFailure) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Buat Store Gagal: ${state.error}')),
                  );
                }
              },
              child: Column(
                children: <Widget>[
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/stores.png"),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Buat toko anda sendiri \n untuk menyewakan kostum anda",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          child: Text(
                            "Nama Toko",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        TextField(
                          controller: storeName,
                          decoration: const InputDecoration(
                            hintText: 'Ex: RentCost',
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 20.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // Password Input Field
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          child: Text(
                            "Lokasi Toko",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        TextField(
                          controller: locationName,
                          decoration: InputDecoration(
                            hintText: 'Ex: Balikpapan',
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 20.0,
                            ),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        final nameText = storeName.text.trim();
                        final locationText = locationName.text.trim();
                        print(nameText);
                        print(locationText);

                        if (nameText.isNotEmpty && locationText.isNotEmpty) {
                          context.read<StoreBloc>().add(
                                StoreCreate(
                                    store_name: nameText,
                                    store_location: locationText),
                              );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Field tidak boleh kosong'),
                            ),
                          );
                        }
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF881FFF),
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: const Center(
                          child: Text(
                            "Buat Toko",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
