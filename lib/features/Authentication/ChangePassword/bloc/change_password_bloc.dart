import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rentcost/features/Authentication/ChangePassword/bloc/change_password_event.dart';
import 'package:rentcost/features/Authentication/ChangePassword/bloc/change_password_state.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_bloc.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_state.dart';
import 'package:rentcost/config/config.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final LoginBloc loginBloc;
  ChangePasswordBloc({required this.loginBloc})
      : super(ChangePasswordInitial()) {
    on<ChangePasswordRequest>(_onChangePasswordRequest);
  }

  Future<void> _onChangePasswordRequest(
      ChangePasswordRequest event, Emitter<ChangePasswordState> emit) async {
    emit(ChangePasswordLoading());
    try {
      final token = (loginBloc.state is LoginSuccess)
          ? (loginBloc.state as LoginSuccess).token
          : null;

      if (token == null) {
        emit(ChangePasswordFailure(error: 'Token tidak ada'));
        return Future.error('Token tidak ada');
      }

      if (event.newPassword != event.confPassword) {
        emit(ChangePasswordFailure(
            error: "Password baru dan konfirmasi password tidak sama"));
      }

      final response = await http.patch(
        Uri.parse('${UrlApi.baseUrl}/auth/change-password'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'oldPassword': event.oldPassword,
          'NewPassword': event.newPassword
        }),
      );

      if (response.statusCode == 200) {
        emit(ChangePasswordSuccess(message: "Berhasil mengubah password"));
      } else {
        final errorData = response.body.isNotEmpty
            ? jsonDecode(response.body)
            : {'error': 'Tidak ada detail error dari server'};
        emit(ChangePasswordFailure(error: errorData));
      }
    } catch (e) {
      print(e);
      emit(ChangePasswordFailure(error: 'Terjadi kesalahan, coba lagi.'));
    }
  }
}
