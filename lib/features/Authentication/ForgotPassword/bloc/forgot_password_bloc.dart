import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rentcost/features/Authentication/ForgotPassword/bloc/forgot_password_event.dart';
import 'package:rentcost/features/Authentication/ForgotPassword/bloc/forgot_password_state.dart';
import 'package:rentcost/config/config.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<ForgotPasswordRequest>(_onForgotPasswordRequest);
  }

  Future<void> _onForgotPasswordRequest(
      ForgotPasswordRequest event, Emitter<ForgotPasswordState> emit) async {
    emit(ForgotPasswordLoading());
    try {
      final response = await http.patch(
        Uri.parse('${UrlApi.baseUrl}/auth/confirm-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'token': event.token,
          'password': event.password,
          'confirm_password': event.confirm_password
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final message = data['message'];
        emit(ForgotPasswordSuccess(message: message));
        // emit(VerifyEmailSuccess(message: "", token: "") as ForgotPasswordState);
      } else {
        final data = jsonDecode(response.body);
        emit(ForgotPasswordFailure(error: data['message']));
      }
    } catch (e) {
      emit(ForgotPasswordFailure(error: e.toString()));
    }
  }
}
