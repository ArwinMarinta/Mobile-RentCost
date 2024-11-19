import 'package:rentcost/features/view/add_address.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentSuccess extends StatefulWidget {
  const PaymentSuccess({super.key});

  @override
  State<PaymentSuccess> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(6.0),
            // Radius untuk sudut membulat
            child: Image.asset(
              'assets/success.png',
              fit: BoxFit.cover,
              width: 100.0,
              height: 100.0,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            "You request has been processed successfully",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 50.0,
          ),
          GestureDetector(
            onTap: () {
              context.go('/my-order');
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: Color(0xFF881FFF)),
              child: Text(
                "Riwayat Pesanan",
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          GestureDetector(
            onTap: () {
              context.go('/');
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
              decoration: BoxDecoration(color: Colors.white),
              child: Text("Kembali ke Beranda"),
            ),
          )
        ],
      ),
    );
  }
}
