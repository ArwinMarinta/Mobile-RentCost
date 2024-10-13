import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:RentCost/features/model/history.dart';

class CardHistoryTenant extends StatefulWidget {
  final History history;

  const CardHistoryTenant({required this.history, super.key});

  @override
  State<CardHistoryTenant> createState() => _CardHistoryTenantState();
}

class _CardHistoryTenantState extends State<CardHistoryTenant> {
  // Tambahkan variable untuk menyimpan status yang dipilih
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    // Inisialisasi dengan status saat ini
    selectedStatus = widget.history.status;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black, width: 0.5))),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          selectedStatus == 'Pembayaran Gagal'
                              ? FontAwesome.credit_card_solid
                              : selectedStatus == 'Dalam Pengiriman'
                                  ? FontAwesome.truck_fast_solid
                                  : selectedStatus == 'Pesanan Diterima'
                                      ? FontAwesome.box_open_solid
                                      : null,
                          color: selectedStatus == 'Pembayaran Gagal'
                              ? Color(0xFFEA5455)
                              : selectedStatus == 'Dalam Pengiriman'
                                  ? Color(0xFF0FB7FF)
                                  : selectedStatus == 'Pesanan Diterima'
                                      ? Color(0xFF28C76F)
                                      : null,
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        DropdownButton<String>(
                          value: selectedStatus,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedStatus = newValue;
                            });
                          },
                          items: <String>[
                            'Pembayaran Gagal',
                            'Dalam Pengiriman',
                            'Pesanan Diterima'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: value == 'Pembayaran Gagal'
                                        ? Color(0xFFEA5455)
                                        : value == 'Dalam Pengiriman'
                                            ? Color(0xFF0FB7FF)
                                            : value == 'Pesanan Diterima'
                                                ? Color(0xFF28C76F)
                                                : null),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.go('/detail-history');
                    },
                    child: Icon(Bootstrap.chevron_right),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              'x${widget.history.quantity} product',
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 15.0),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.circular(6.0)),
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: Image.asset(
                      widget.history.image,
                      fit: BoxFit.cover,
                      width: 100.0,
                      height: 100.0,
                    ),
                  ),
                  SizedBox(width: 6.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: Image.asset(
                      widget.history.image,
                      fit: BoxFit.cover,
                      width: 100.0,
                      height: 100.0,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
