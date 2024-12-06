import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rentcost/features/Authentication/ForgotPassword/bloc/verify_email_event.dart';
import 'package:rentcost/features/Authentication/ForgotPassword/bloc/verify_email_state.dart';
import 'package:rentcost/config/config.dart';

class VerifyEmailBloc extends Bloc<VerifyEmailEvent, VerifyEmailState> {
  VerifyEmailBloc() : super(VerifyEmailInitial()) {
    on<VerifyEmailRequest>(_onVerifyEmailRequest);
    on<RessetToken>(_onRessetToken);
  }

  Future<void> _onVerifyEmailRequest(
      VerifyEmailRequest event, Emitter<VerifyEmailState> emit) async {
    emit(VerifyEmailLoading());
    try {
      final response = await http.post(
        Uri.parse('${UrlApi.baseUrl}/auth/reset-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': event.email,
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        final message = data['message'];
        emit(VerifyEmailSuccess(message: message, token: token));
        // emit(VerifyEmailLoaded(token: token));
      } else {
        final data = jsonDecode(response.body);
        emit(VerifyEmailFailure(error: data['message']));
      }
    } catch (e) {
      print(e.toString());
      emit(VerifyEmailFailure(error: 'Terjadi kesalahan, coba lagi.'));
    }
  }

  void _onRessetToken(RessetToken event, Emitter<VerifyEmailState> emit) {
    // Reset token dalam state
    emit(VerifyEmailSuccess(message: "", token: ""));
  }
}
