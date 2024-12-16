import 'package:equatable/equatable.dart';

abstract class HistoriUserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class HistoriUserClear extends HistoriUserEvent {}

class HistoriUserUserRequest extends HistoriUserEvent {
  HistoriUserUserRequest();

  @override
  List<Object> get props => [];
}

class PostRatingRequest extends HistoriUserEvent {
  final int totalRating;
  final int productId;
  final int transactiId;

  PostRatingRequest({
    required this.totalRating,
    required this.productId,
    required this.transactiId,
  });

  @override
  List<Object> get props => [totalRating, productId, transactiId];
}
