import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool passwordVisible = true;
  bool confPasswordVisible = true;

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
            context.go("/verify-email");
          },
          child: const Icon(
            FontAwesome.chevron_left_solid,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 50.0,
              ),
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 150.0,
                      height: 150.0,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage("assets/rencost_logo.png"),
                      )),
                    ),
                    const Text(
                      "RenCost",
                      style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF881FFF)),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                "Masukan password baru",
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF881FFF)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Password yang baru harus berbeda dengan \n password sebelumnya.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              SizedBox(
                height: 30.0,
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
              SizedBox(
                height: 30.0,
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
                      controller: confirmPassword,
                      onChanged: null,
                      obscureText: confPasswordVisible,
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
                              confPasswordVisible = !confPasswordVisible;
                            });
                          },
                          child: Icon(confPasswordVisible
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
            ],
          ),
        ),
      ),
    );
  }
}
