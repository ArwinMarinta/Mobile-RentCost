import 'package:equatable/equatable.dart';

abstract class HistoriEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// class HistoriUserRequest extends HistoriEvent {
//   HistoriUserRequest();

//   @override
//   List<Object> get props => [];
// }

class HistoriTenantClear extends HistoriEvent {}

class HistoriTenantRequest extends HistoriEvent {
  HistoriTenantRequest();

  @override
  List<Object> get props => [];
}

// class PostRatingRequest extends HistoriEvent {
//   final int totalRating;
//   final int productId;
//   final int transactiId;

//   PostRatingRequest({
//     required this.totalRating,
//     required this.productId,
//     required this.transactiId,
//   });

//   @override
//   List<Object> get props => [totalRating, productId, transactiId];
// }

class UpdateStatusRequest extends HistoriEvent {
  final int transaction_id;
  final String status;
  UpdateStatusRequest({required this.transaction_id, required this.status});

  @override
  List<Object> get props => [transaction_id, status];
}
