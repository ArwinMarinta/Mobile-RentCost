import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

class AddCostum extends StatefulWidget {
  const AddCostum({super.key});

  @override
  State<AddCostum> createState() => _AddCostumState();
}

class _AddCostumState extends State<AddCostum> {
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
              context.go("/profile");
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
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
                      // controller: email,
                      onChanged: null,
                      decoration: const InputDecoration(
                        hintText: 'Nama Costum',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF8E8E8E), width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
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
                      onChanged: null,
                      decoration: const InputDecoration(
                        hintText: 'Harga',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF8E8E8E), width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
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
                        "Stok",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      onChanged: null,
                      decoration: const InputDecoration(
                        hintText: 'ex: 1',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF8E8E8E), width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
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
                        "Category",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      onChanged: null,
                      decoration: const InputDecoration(
                        hintText: 'ex: 1',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF8E8E8E), width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
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
                        "Size",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      onChanged: null,
                      decoration: const InputDecoration(
                        hintText: 'ex: M',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF8E8E8E), width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
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
    );
  }
}
