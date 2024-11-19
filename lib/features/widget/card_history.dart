import 'package:flutter/material.dart';
import 'package:rentcost/features/model/history.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:go_router/go_router.dart';

class CardHistory extends StatefulWidget {
  final History history;

  const CardHistory({required this.history, super.key});

  @override
  State<CardHistory> createState() => _CardHistoryState();
}

class _CardHistoryState extends State<CardHistory> {
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
                            widget.history.status == 'Pembayaran Gagal'
                                ? FontAwesome.credit_card_solid
                                : widget.history.status == 'Dalam Pengiriman'
                                    ? FontAwesome.truck_fast_solid
                                    : widget.history.status ==
                                            'Pesanan Diterima'
                                        ? FontAwesome.box_open_solid
                                        : null,
                            color: widget.history.status == 'Pembayaran Gagal'
                                ? Color(0xFFEA5455)
                                : widget.history.status == 'Dalam Pengiriman'
                                    ? Color(0xFF0FB7FF)
                                    : widget.history.status ==
                                            'Pesanan Diterima'
                                        ? Color(0xFF28C76F)
                                        : null),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Column(
                          children: [
                            Text(
                              widget.history.status,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: widget.history.status ==
                                          'Pembayaran Gagal'
                                      ? Color(0xFFEA5455)
                                      : widget.history.status ==
                                              'Dalam Pengiriman'
                                          ? Color(0xFF0FB7FF)
                                          : widget.history.status ==
                                                  'Pesanan Diterima'
                                              ? Color(0xFF28C76F)
                                              : null),
                            ),
                          ],
                        )
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
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'x${widget.history.quantity} product',
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 15.0,
            ),
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
                  SizedBox(
                    width: 6.0,
                  ),
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
