import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductPopuler extends ProductEvent {
  ProductPopuler();

  @override
  List<Object> get props => [];
}

class ProductNews extends ProductEvent {
  ProductNews();

  @override
  List<Object> get props => [];
}

class ProductFilter extends ProductEvent {
  ProductFilter();

  @override
  List<Object> get props => [];
}

class ProductSearch extends ProductEvent {
  final String search;

  ProductSearch({required this.search});
}
