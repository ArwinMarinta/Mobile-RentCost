import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:rentcost/config/config.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_bloc.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_state.dart';
import 'package:rentcost/features/SplashScreen/bloc/splash_event.dart';
import 'package:rentcost/features/SplashScreen/bloc/splash_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<CheckTokenEvent>(_onCheckTokenEvent);
  }

  Future<void> _onCheckTokenEvent(
      CheckTokenEvent event, Emitter<SplashState> emit) async {
    emit(SplashLoading());

    try {
      // Cek token dari LoginBloc
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');
      // final expiryTime = prefs.getInt('token_expiry_time');

      // if (token != null && expiryTime != null) {
      //   final currentTime = DateTime.now().millisecondsSinceEpoch;

      //   if (currentTime < expiryTime) {
      //     emit(SplashNavigateToDashboard(message: "Token ada"));
      //   } else {
      //     print("refresh ulang");
      //     final response = await http.post(
      //       Uri.parse('${UrlApi.baseUrl}/auth/refresh-token'),
      //       headers: {'Content-Type': 'application/json'},
      //       body: jsonEncode({'access_token': token}),
      //     );

      //     if (response.statusCode == 201) {
      //       final responseData = jsonDecode(response.body);
      //       final newToken = responseData['data'];
      //       final newExpiryTime = DateTime.now()
      //           .add(Duration(seconds: 30))
      //           .millisecondsSinceEpoch;

      //       await prefs.setString('access_token', newToken);
      //       await prefs.setInt('token_expiry_time', newExpiryTime);

      //       emit(SplashNavigateToDashboard(message: "Token ada"));
      //     } else {
      //       emit(SplashNavigateToLogin(message: "Token tidak ada"));
      //     }
      //   }
      // } else {
      //   emit(SplashNavigateToLogin(message: "Token tidak ada"));
      // }

      if (token == null) {
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
