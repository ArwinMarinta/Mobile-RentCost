import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentcost/features/users/bloc/user_event.dart';
import 'package:rentcost/features/users/bloc/user_state.dart';
import 'package:rentcost/features/users/bloc/user_bloc.dart';

class Personal extends StatelessWidget {
  Personal({super.key});

  final TextEditingController image = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();

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
            Padding(padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2)),
            Text(
              "Informasi Pribadi",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserInitial) {
            context.read<UserBloc>().add(UserRequest());
          } else if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is UserLoaded) {
            final data = state.data;

            image.text = data.first.data.user.imageUrl;
            username.text = data.first.data.user.username;
            email.text = data.first.data.email;
            phoneNumber.text = data.first.data.user.phoneNumber;

            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100.0)),
                        child: Image.network(
                          data.first.data.user.imageUrl,
                          fit: BoxFit.cover,
                          width: 100.0,
                          height: 100.0,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.account_circle,
                              size: 100.0,
                              color: Colors.grey,
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return SizedBox(
                              width: 100.0,
                              height: 100.0,
                              child: Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes!)
                                      : null,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    _buildTextField("Username", username,
                        hintText: "Your Name"),
                    const SizedBox(height: 20.0),
                    _buildTextField(
                      "Email",
                      email,
                      hintText: null,
                      enabled: false,
                    ),
                    const SizedBox(height: 20.0),
                    _buildTextField(
                      "Phone Number",
                      phoneNumber,
                      hintText: "Your Phone Numbers",
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(child: Text("Error loading user data"));
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: GestureDetector(
          onTap: () {
            // Add save functionality here
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
                  'Simpan',
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

  Widget _buildTextField(String label, TextEditingController controller,
      {String? hintText, bool enabled = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        TextField(
          controller: controller,
          enabled: enabled,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF8E8E8E), width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
              borderSide: BorderSide(color: Color(0xFF881FFF), width: 2.0),
            ),
          ),
        ),
      ],
    );
  }
}
