import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rentcost/config/config.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_bloc.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_state.dart';
import 'package:rentcost/features/SplashScreen/bloc/splash_event.dart';
import 'package:rentcost/features/SplashScreen/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final LoginBloc loginBloc;

  SplashBloc({required this.loginBloc}) : super(SplashInitial()) {
    on<CheckTokenEvent>(_onCheckTokenEvent);
  }

  Future<void> _onCheckTokenEvent(
      CheckTokenEvent event, Emitter<SplashState> emit) async {
    emit(SplashLoading());

    try {
      // Cek token dari LoginBloc
      final token = (loginBloc.state is LoginSuccess)
          ? (loginBloc.state as LoginSuccess).token
          : null;

      if (token == null) {
        // Jika token tidak ada, navigasikan ke login
        emit(SplashNavigateToLogin(message: "Token tidak ada"));
      } else {
        // Jika token ada, navigasikan ke dashboard
        emit(SplashNavigateToDashboard(message: "Token ada"));
      }
    } catch (e) {
      print('Error: $e');
      emit(SplashFailure(error: 'Terjadi kesalahan saat memeriksa token'));
    }
  }
}
