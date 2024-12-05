import 'package:equatable/equatable.dart';

abstract class CategoriesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CategoriesRequest extends CategoriesEvent {
  CategoriesRequest();

  @override
  List<Object> get props => [];
}

class CategoriesCreateEvent extends CategoriesEvent {
  final String file;
  final String category_name;
  CategoriesCreateEvent({required this.file, required this.category_name});

  @override
  List<Object> get props => [file, category_name];
}

class CategoriesDeleteEvent extends CategoriesEvent {
  final int id;

  CategoriesDeleteEvent({required this.id});

  @override
  List<Object> get props => [id];
}
