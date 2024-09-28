import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController noTelp = TextEditingController();
  TextEditingController password = TextEditingController();

  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

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
              context.go("/login");
            },
            child: const Icon(
              FontAwesome.chevron_left_solid,
              color: Color(0xFF881FFF),
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
                "Daftar Pengguna",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFF881FFF),
                    fontWeight: FontWeight.bold),
              ),
            ],
          )),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      child: Text(
                        "Nama Lengkap",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      controller: fullName,
                      onChanged: null,
                      decoration: InputDecoration(
                        hintText: 'Masukkan Nama Lengkap',
                        // labelText: "Password",
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey[400] ?? Colors.grey,
                              width: 1.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6.0)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(
                              color: Color(0xFF881FFF),
                              width: 2.0), // Mengatur border saat fokus
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
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
                        "Email",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      controller: email,
                      onChanged: null,
                      decoration: InputDecoration(
                        hintText: 'Masukkan Email',
                        // labelText: "Password",
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey[400] ?? Colors.grey,
                              width: 1.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6.0)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(
                              color: Color(0xFF881FFF),
                              width: 2.0), // Mengatur border saat fokus
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
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
                        "Nomor Telphone",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      controller: noTelp,
                      onChanged: null,
                      decoration: InputDecoration(
                        hintText: 'Masukkan No Telpn',
                        // labelText: "Password",
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey[400] ?? Colors.grey,
                              width: 1.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6.0)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(
                              color: Color(0xFF881FFF),
                              width: 2.0), // Mengatur border saat fokus
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
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
                        "Password",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      controller: password,
                      onChanged: null,
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                        hintText: 'Masukkan Password',
                        // labelText: "Password",
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey[400] ?? Colors.grey,
                              width: 1.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6.0)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(
                              color: Color(0xFF881FFF),
                              width: 2.0), // Mengatur border saat fokus
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                          child: Icon(passwordVisible
                              ? Bootstrap.eye
                              : Bootstrap.eye_slash),
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                width: double.infinity,
                child: GestureDetector(
                  onTap: null,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color(0xFF881FFF),
                        borderRadius: BorderRadius.all(Radius.circular(6.0))),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: const Center(
                        child: Text(
                      "Daftar",
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
