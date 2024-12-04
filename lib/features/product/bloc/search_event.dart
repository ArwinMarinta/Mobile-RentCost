import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchProductEvent extends SearchEvent {
  final String search;

  SearchProductEvent({required this.search});
}

class SearchResetEvent extends SearchEvent {}
