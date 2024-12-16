import 'package:equatable/equatable.dart';

abstract class PaymentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PaymentRequest extends PaymentEvent {
  final String price;
  final String productId;
  final String paymentImage;

  PaymentRequest(
      {required this.price,
      required this.paymentImage,
      required this.productId});

  @override
  List<Object> get props => [price, paymentImage, productId];
}
