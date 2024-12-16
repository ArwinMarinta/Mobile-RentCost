import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rentcost/features/Authentication/Login/bloc/login_bloc.dart';
import 'package:rentcost/features/users/bloc/user_event.dart';
import 'package:rentcost/features/users/bloc/user_state.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_state.dart';
import 'package:rentcost/features/users/model/user_model.dart';
import 'package:rentcost/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserRequest>((event, emit) async {
      emit(UserLoading());
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('access_token');

        if (token == null) {
          emit(UserFailure(error: 'Token tidak ada'));
          return;
        }

        final response = await http.get(
          Uri.parse('${UrlApi.baseUrl}/users'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> data = jsonDecode(response.body);

          UserResponse user = UserResponse.fromJson(data);

          emit(UserLoaded(data: user));
        } else {
          final errorData = response.body.isNotEmpty
              ? jsonDecode(response.body)
              : {'error': 'Tidak ada detail error dari server'};
          emit(UserFailure(error: errorData['error'] ?? 'User gagal'));
        }
      } catch (e) {
        emit(UserFailure(error: 'Terjadi kesalahan, coba lagi.'));
      }
    });

    on<UserClear>((event, emit) {
      emit(UserInitial());
    });
  }
}
