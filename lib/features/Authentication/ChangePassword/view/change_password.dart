import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:rentcost/features/Authentication/ChangePassword/bloc/change_password_bloc.dart';
import 'package:rentcost/features/Authentication/ChangePassword/bloc/change_password_event.dart';
import 'package:rentcost/features/Authentication/ChangePassword/bloc/change_password_state.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController newPassword = TextEditingController();
  TextEditingController confPassword = TextEditingController();
  TextEditingController oldPassword = TextEditingController();

  bool newPasswordVisible = true;
  bool confPasswordVisible = true;
  bool oldPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is ChangePasswordSuccess) {
          Navigator.of(context).pop(); // Close loading dialog
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

          setState(() {
            oldPassword.clear();
            confPassword.clear();
            newPassword.clear();
          });
        } else if (state is ChangePasswordFailure) {
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
                  "Ubah Password",
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
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Masukkan Password Lama",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        controller: oldPassword,
                        obscureText: oldPasswordVisible,
                        decoration: InputDecoration(
                          hintText: '*****',
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 20.0,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                oldPasswordVisible = !oldPasswordVisible;
                              });
                            },
                            child: Icon(oldPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Masukkan Password Baru",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        controller: newPassword,
                        obscureText: newPasswordVisible,
                        decoration: InputDecoration(
                          hintText: '*****',
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 20.0,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                newPasswordVisible = !newPasswordVisible;
                              });
                            },
                            child: Icon(newPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ulangi Password Baru",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        controller: confPassword,
                        obscureText: confPasswordVisible,
                        decoration: InputDecoration(
                          hintText: '*****',
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 20.0,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                confPasswordVisible = !confPasswordVisible;
                              });
                            },
                            child: Icon(confPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16.0,
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
              onTap: () {
                final newPasswordText = newPassword.text.trim();
                final oldPasswordText = oldPassword.text.trim();
                final confPasswordText = confPassword.text.trim();

                if (newPasswordText.isNotEmpty &&
                    oldPasswordText.isNotEmpty &&
                    confPasswordText.isNotEmpty) {
                  context.read<ChangePasswordBloc>().add(ChangePasswordRequest(
                      oldPassword: oldPasswordText,
                      newPassword: newPasswordText,
                      confPassword: confPasswordText));
                }
              },
              child: Container(
                decoration: const BoxDecoration(
                    color: Color(0xFF881FFF),
                    borderRadius: BorderRadius.all(Radius.circular(6.0))),
                // padding: const EdgeInsets.all(16.0),
                child: const Center(
                  child: Text(
                    'Ubah Password',
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
