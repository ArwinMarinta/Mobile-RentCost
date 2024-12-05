import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rentcost/features/Authentication/Register/bloc/register_event.dart';
import 'package:rentcost/features/Authentication/Register/bloc/register_state.dart';
import 'package:rentcost/config/config.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterRequest>(_onRegisterRequest);
  }

  Future<void> _onRegisterRequest(
      RegisterRequest event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    try {
      final response = await http.post(
        Uri.parse('${UrlApi.baseUrl}/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': event.username,
          'email': event.email,
          'phone_number': event.phone_number,
          'password': event.password
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final message = data['message'];
        print(message);
        emit(RegisterSuccess(message: message));
      } else {
        final errorData = response.body.isNotEmpty
            ? jsonDecode(response.body)
            : {'error': 'Tidak ada detail error dari server'};
        emit(RegisterFailure(error: errorData['message'] ?? 'Register gagal'));
      }
    } catch (e) {
      print(e);
      emit(RegisterFailure(error: 'Terjadi kesalahan, coba lagi.'));
    }
  }
}
