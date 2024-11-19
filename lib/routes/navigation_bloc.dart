import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationState {
  final String currentLocation;

  NavigationState(this.currentLocation);
}

class NavigationBloc extends Cubit<NavigationState> {
  NavigationBloc() : super(NavigationState('/'));

  void updateLocation(String newLocation) {
    emit(NavigationState(newLocation));
  }
}
