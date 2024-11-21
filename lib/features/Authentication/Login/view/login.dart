import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_bloc.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_event.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
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
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginLoading) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is LoginSuccess) {
                Navigator.of(context).pop(); // Close loading dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Login Berhasil: ${state.token}')),
                );

                context.go('/banner'); // Ganti dengan rute yang sesuai
              } else if (state is LoginFailure) {
                Navigator.of(context).pop(); // Close loading dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Login Gagal: ${state.error}')),
                );
              }
            },
            child: Column(
              children: <Widget>[
                const SizedBox(height: 50.0),
                Container(
                  child: Column(
                    children: [
                      Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/rencost_logo.png"),
                          ),
                        ),
                      ),
                      const Text(
                        "RenCost",
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF881FFF),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),
                // Email Input Field
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        child: Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      TextField(
                        controller: email,
                        decoration: const InputDecoration(
                          hintText: 'Masukkan Email',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            child: Text(
                              "Password",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                context.go('/verify-email');
                              });
                            },
                            child: const Text(
                              "Lupa Kata Sandi",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF881FFF),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      TextField(
                        controller: password,
                        obscureText: passwordVisible,
                        decoration: InputDecoration(
                          hintText: 'Masukkan Password',
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
                                passwordVisible = !passwordVisible;
                              });
                            },
                            child: Icon(passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25.0),
                // Login Button
                Container(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {
                      final emailText = email.text.trim();
                      final passwordText = password.text.trim();
                      print(emailText);
                      print(passwordText);
                      if (emailText.isNotEmpty && passwordText.isNotEmpty) {
                        context.read<LoginBloc>().add(
                              LoginRequest(
                                email: emailText,
                                password: passwordText,
                              ),
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
                          "Masuk",
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
                const SizedBox(height: 40),
                // Register Link
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Belum Punya Akun?",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Text(" "),
                      GestureDetector(
                        onTap: () {
                          context.go('/register');
                        },
                        child: const Text(
                          "Daftar Di Sini",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF881FFF),
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
      ),
    );
  }
}
