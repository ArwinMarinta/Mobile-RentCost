import 'package:equatable/equatable.dart';
import 'package:rentcost/features/banner/model/banner_model.dart';

abstract class BannerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BannerInitial extends BannerState {}

class BannerLoading extends BannerState {}

class BannerSuccess extends BannerState {
  final String message;

  BannerSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class BannerFailure extends BannerState {
  final String error;

  BannerFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class BannerLoaded extends BannerState {
  final List<BannerResponse> banner;

  BannerLoaded({required this.banner});
}

class BannerCreateLoading extends BannerState {}

class BannerCreateSuccess extends BannerState {
  final String message;

  BannerCreateSuccess({required this.message});
}

class BannerCreateFailure extends BannerState {
  final String error;

  BannerCreateFailure({required this.error});

  @override
  List<Object> get props => [error];
}
