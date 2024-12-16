import 'package:equatable/equatable.dart';
import 'package:rentcost/features/users/model/user_model.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final Map<String, dynamic> data;

  UserSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

final class UserFailure extends UserState {
  final String error;

  UserFailure({required this.error});

  @override
  List<Object> get props => [error];
}

final class UserLoaded extends UserState {
  final UserResponse data;

  UserLoaded({required this.data});

  @override
  List<Object> get props => [data];
}
