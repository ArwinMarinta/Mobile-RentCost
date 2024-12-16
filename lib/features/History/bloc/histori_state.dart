import 'package:equatable/equatable.dart';
import 'package:rentcost/features/History/model/histori.dart';

abstract class HistoriState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HistoriInitial extends HistoriState {}

class HistoriLoading extends HistoriState {}

class HistoriUserLoading extends HistoriState {}

class HistoriUserSuccess extends HistoriState {
  final String message;

  HistoriUserSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class HistoriUserFailure extends HistoriState {
  final String error;

  HistoriUserFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class HistoriUserLoaded extends HistoriState {
  final HistoryResponse history;

  HistoriUserLoaded({required this.history});
}

class HistoriTenantLoading extends HistoriState {}

class HistoriTenantSuccess extends HistoriState {
  final String message;

  HistoriTenantSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class HistoriTenantFailure extends HistoriState {
  final String error;

  HistoriTenantFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class HistoriTenantLoaded extends HistoriState {
  final HistoryResponse history;

  HistoriTenantLoaded({required this.history});
}

class UpdateStatusLoading extends HistoriState {}

class UpdateStatusSuccess extends HistoriState {
  final String message;

  UpdateStatusSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class UpdateStatusFailure extends HistoriState {
  final String error;

  UpdateStatusFailure({required this.error});

  @override
  List<Object> get props => [error];
}
