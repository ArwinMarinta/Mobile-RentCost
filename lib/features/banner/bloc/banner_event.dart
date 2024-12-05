import 'package:equatable/equatable.dart';

abstract class BannerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class BannerRequest extends BannerEvent {
  BannerRequest();

  @override
  List<Object> get props => [];
}

class BannerCreateEvent extends BannerEvent {
  final String file;
  final String banner_name;
  BannerCreateEvent({required this.file, required this.banner_name});

  @override
  List<Object> get props => [file, banner_name];
}

class BannerDeleteEvent extends BannerEvent {
  final int id;

  BannerDeleteEvent({required this.id});

  @override
  List<Object> get props => [id];
}
