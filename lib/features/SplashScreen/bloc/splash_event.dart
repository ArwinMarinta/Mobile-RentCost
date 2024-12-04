import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckTokenEvent extends SplashEvent {
  CheckTokenEvent();

  @override
  List<Object> get props => [];
}
