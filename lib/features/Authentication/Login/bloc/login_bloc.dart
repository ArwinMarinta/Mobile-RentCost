import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rentcost/features/Authentication/Login/bloc/login_event.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginRequest>(_onLoginRequest);
  }

  Future<void> _onLoginRequest(
      LoginRequest event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final response = await http.post(
        Uri.parse('https://cc31-36-85-35-19.ngrok-free.app/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': event.email, 'password': event.password}),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final accessToken = data['data']['access_token'];
        print(accessToken);
        emit(LoginSuccess(token: accessToken));
      } else {
        final errorData = response.body.isNotEmpty
            ? jsonDecode(response.body)
            : {'error': 'Tidak ada detail error dari server'};
        emit(LoginFailure(error: errorData['error'] ?? 'Login gagal'));
      }
    } catch (e) {
      print(e);
      emit(LoginFailure(error: 'Terjadi kesalahan, coba lagi.'));
    }
  }
}
