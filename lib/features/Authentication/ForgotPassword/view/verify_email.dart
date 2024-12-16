import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:rentcost/features/Authentication/ForgotPassword/bloc/verify_email_bloc.dart';
import 'package:rentcost/features/Authentication/ForgotPassword/bloc/verify_email_event.dart';
import 'package:rentcost/features/Authentication/ForgotPassword/bloc/verify_email_state.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<VerifyEmailBloc, VerifyEmailState>(
      listener: (context, state) {
        if (state is VerifyEmailLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is VerifyEmailSuccess) {
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

          Future.delayed(const Duration(seconds: 3), () {
            context.go('/forgot-password?token=${state.token}');
          });
        } else if (state is VerifyEmailFailure) {
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
              context.go("/login");
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
            margin:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
            child: Column(
              children: <Widget>[
                Center(
                  child: Container(
                    width: 300.0,
                    height: 300.0,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/icon_verify_email.png"),
                    )),
                  ),
                ),
                const Text(
                  "Atur ulang kata sandi",
                  style: TextStyle(
                      fontSize: 25.0,
                      color: Color(0xFF881FFF),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  "Masukkan e-mail  yang terdaftar Kami akan \n mengirimkan kode verifikasi untuk atur ulang kata sandi",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30.0,
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
                        decoration: const InputDecoration(
                          hintText: 'Masukkan Email Verifikasi',
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
                  height: 40,
                ),
                SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {
                      final emailText = email.text.trim();

                      if (emailText.isNotEmpty) {
                        context
                            .read<VerifyEmailBloc>()
                            .add(VerifyEmailRequest(email: emailText));
                      }
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Color(0xFF881FFF),
                          borderRadius: BorderRadius.all(Radius.circular(6.0))),
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: const Center(
                          child: Text(
                        "Kirim",
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
      ),
    );
  }
}
