import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rentcost/features/Authentication/Login/bloc/login_event.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_state.dart';
import 'package:rentcost/config/config.dart';
import 'package:rentcost/features/users/bloc/user_bloc.dart';
import 'package:rentcost/features/users/bloc/user_event.dart';
import 'package:rentcost/features/users/bloc/user_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginRequest>(_onLoginRequest);
    on<LogoutRequest>(_onLogputRequest);
  }

  Future<void> _onLoginRequest(
      LoginRequest event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final response = await http.post(
        Uri.parse('${UrlApi.baseUrl}/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': event.email, 'password': event.password}),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final accessToken = data['data']['access_token'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', accessToken);
        emit(LoginSuccess(message: "Login berhasil"));
      } else {
        final errorData = response.body.isNotEmpty
            ? jsonDecode(response.body)
            : {'error': 'Tidak ada detail error dari server'};
        emit(LoginFailure(error: errorData['message'] ?? 'Login gagal'));
      }
    } catch (e) {
      emit(LoginFailure(error: 'Terjadi kesalahan, coba lagi.'));
    }
  }

  Future<void> _onLogputRequest(
      LogoutRequest event, Emitter<LoginState> emit) async {
    emit(LogoutLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      emit(LoginSuccess(
        message: 'Logout berhasil',
      ));
    } catch (e) {
      emit(LogoutFailure(error: 'Logout gagal, coba lagi.'));
    }
  }
}
