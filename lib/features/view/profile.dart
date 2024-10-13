import 'package:RentCost/features/view/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        title: const Center(child: Text("AKUN SAYA")),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Aktivitas",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            context.go('/personal');
                          });
                        },
                        child: const Row(
                          children: [
                            Icon(
                              Bootstrap.person,
                            ),
                            SizedBox(width: 12.0),
                            Text(
                              "Data Diri",
                              style: TextStyle(fontSize: 18.0),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            context.go('/my-order');
                          });
                        },
                        child: const Row(
                          children: [
                            Icon(
                              Bootstrap.box_seam,
                            ),
                            SizedBox(width: 12.0),
                            Text(
                              "Pesanan",
                              style: TextStyle(fontSize: 18.0),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            context.go('/change-password');
                          });
                        },
                        child: const Row(
                          children: [
                            Icon(
                              Bootstrap.shield_lock,
                            ),
                            SizedBox(width: 12.0),
                            Text(
                              "Ubah Password",
                              style: TextStyle(fontSize: 18.0),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Pembayaran",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          context.go('/confirm-payment');
                        });
                      },
                      child: const Row(
                        children: [
                          Icon(Bootstrap.bank),
                          SizedBox(width: 12.0),
                          Text(
                            "Konfirmasi Pembayaran",
                            style: TextStyle(fontSize: 18.0),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Admin",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          context.go('/banner');
                        });
                      },
                      child: const Row(
                        children: [
                          Icon(Bootstrap.bank),
                          SizedBox(width: 12.0),
                          Text(
                            "Banner",
                            style: TextStyle(fontSize: 18.0),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          context.go('/category');
                        });
                      },
                      child: const Row(
                        children: [
                          Icon(Bootstrap.bank),
                          SizedBox(width: 12.0),
                          Text(
                            "Kategori",
                            style: TextStyle(fontSize: 18.0),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Bantuan",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        child: const Row(
                          children: [
                            Icon(Bootstrap.question_circle),
                            SizedBox(
                              width: 12.0,
                            ),
                            Text(
                              "Pusat Bantuan",
                              style: TextStyle(fontSize: 18.0),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        child: const Row(
                          children: [
                            Icon(Bootstrap.journals),
                            SizedBox(
                              width: 12.0,
                            ),
                            Text(
                              "FAQ",
                              style: TextStyle(fontSize: 18.0),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    context.go("/login");
                  });
                },
                child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6.0))),
                    child: const Center(
                        child: Text(
                      "Keluar",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w700),
                    ))),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Center(child: Text("Versi 1.0.0"))
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Warna shadow
                offset: const Offset(0, -1), // Menggeser shadow ke atas
                blurRadius: 1, // Jarak blur shadow
                spreadRadius: 1, // Jarak spread shadow
              ),
            ],
          ),
          child: const CustomNavigationBar(selectedIndex: 3)),
    );
  }
}
