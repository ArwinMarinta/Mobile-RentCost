import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserClear extends UserEvent {}

class UserRequest extends UserEvent {
  UserRequest();

  @override
  List<Object> get props => [];
}
