import 'package:RentCost/features/widget/cart_payment.dart';
import 'package:RentCost/features/widget/detail_payment.dart';
import 'package:RentCost/features/widget/payment_success.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:timelines_plus/timelines_plus.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  // Status dari pembayaran, bisa diatur sesuai kebutuhan
  String currentStatus = 'Detail'; // Misal status saat ini berada di 'Detail'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2)),
              Text(
                "Pembayaran",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Container(
                // color: Colors.red,
                width: double.infinity,
                child: Center(
                    child: _buildTimeline(['Detail', 'Pembayaran', 'Selesai'])),
              ),
              Container(
                child: currentStatus == "Detail"
                    ? DetailPayment()
                    : currentStatus == "Bayar"
                        ? CardPayment()
                        : currentStatus == "Selesai"
                            ? PaymentSuccess()
                            : null,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeline(List<String> events) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 100.0,
        width: double.infinity, // Mengatur lebar dari tiap timeline
        child: Timeline.tileBuilder(
          scrollDirection: Axis.horizontal,
          builder: TimelineTileBuilder.connected(
            connectionDirection: ConnectionDirection.before,
            connectorBuilder: (context, index, type) {
              // Jika status saat ini berada di 'Detail', garis setelahnya tidak berwarna biru
              if (currentStatus == 'Detail' && index > 0) {
                return SolidLineConnector(
                  color:
                      Colors.grey, // Warna abu-abu untuk konektor tidak aktif
                );
              }
              return SolidLineConnector(
                color: Colors.blue, // Warna biru untuk konektor aktif
              );
            },
            indicatorBuilder: (context, index) {
              // Jika status masih di 'Detail', ganti dot menjadi OutlinedDotIndicator untuk "Pembayaran" dan "Selesai"
              if (currentStatus == 'Detail' && index > 0) {
                return OutlinedDotIndicator(
                  size: 20.0,
                  color: Colors.blue, // Outline berwarna biru
                  borderWidth: 2.0,
                );
              }
              return DotIndicator(
                size: 20.0,
                color: Colors.blue, // Warna biru untuk status aktif
              );
            },
            itemExtent: 135.0,
            contentsBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(events[index]),
            ),
            itemCount: events.length,
          ),
        ),
      ),
    );
  }
}
