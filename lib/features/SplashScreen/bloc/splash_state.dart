import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashNavigateToDashboard extends SplashState {
  final String message;

  SplashNavigateToDashboard({required this.message});

  @override
  List<Object?> get props => [message];
}

class SplashNavigateToLogin extends SplashState {
  final String message;

  SplashNavigateToLogin({required this.message});

  @override
  List<Object?> get props => [message];
}

class SplashFailure extends SplashState {
  final String error;

  SplashFailure({required this.error});

  @override
  List<Object> get props => [error];
}
