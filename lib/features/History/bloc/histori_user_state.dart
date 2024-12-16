import 'package:equatable/equatable.dart';
import 'package:rentcost/features/History/model/histori_user.dart';

abstract class HistoriUserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HistoriUserInitial extends HistoriUserState {}

class HistoriUserLoading extends HistoriUserState {}

class HistoriUserSuccess extends HistoriUserState {
  final String message;

  HistoriUserSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class HistoriUserFailure extends HistoriUserState {
  final String error;

  HistoriUserFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class HistoriUserLoaded extends HistoriUserState {
  final HistoryResponseUser history;

  HistoriUserLoaded({required this.history});
}

class RatingProductLoading extends HistoriUserState {}

class RatingProductSuccess extends HistoriUserState {
  final String message;

  RatingProductSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class RatingProductFailure extends HistoriUserState {
  final String error;

  RatingProductFailure({required this.error});

  @override
  List<Object> get props => [error];
}
