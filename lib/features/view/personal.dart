import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';

class Personal extends StatefulWidget {
  const Personal({super.key});

  @override
  State<Personal> createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
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
                "Informasi Pribadi",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                  // Radius untuk sudut membulat
                  child: Image.asset(
                    'assets/costum1.png',
                    fit: BoxFit.cover,
                    width: 100.0,
                    height: 100.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Username",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      onChanged: null,
                      decoration: InputDecoration(
                        hintText: 'Your Name',
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
              const SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      enabled: false,
                      onChanged: null,
                      decoration: InputDecoration(
                        hintText: 'Your Email',
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
              const SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Phone Number",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      onChanged: null,
                      decoration: InputDecoration(
                        hintText: 'Your Phone Numbers',
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 50.0),
        child: GestureDetector(
          onTap: null,
          child: Container(
            decoration: const BoxDecoration(
                color: Color(0xFF881FFF),
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            child: const Text(
              'Edit',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
