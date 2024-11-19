import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rentcost/features/Authentication/Login/bloc/login_bloc.dart';
import 'package:rentcost/features/users/bloc/user_event.dart';
import 'package:rentcost/features/users/bloc/user_state.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_state.dart';
import 'package:rentcost/features/users/model/user_model.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final LoginBloc loginBloc;

  UserBloc({required this.loginBloc}) : super(UserInitial()) {
    on<UserRequest>((event, emit) async {
      emit(UserLoading());
      try {
        final token = (loginBloc.state is LoginSuccess)
            ? (loginBloc.state as LoginSuccess).token
            : null;

        if (token == null) {
          emit(UserFailure(error: 'Token tidak ada'));
          return;
        }

        print(loginBloc);
        print('Token: $token');

        final response = await http.get(
          Uri.parse('https://cc31-36-85-35-19.ngrok-free.app/users'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> data = jsonDecode(response.body);

          User user = User.fromJson(data);

          emit(UserLoaded(data: [user])); // Membungkus user dalam List
          // print(data);
        } else {
          final errorData = response.body.isNotEmpty
              ? jsonDecode(response.body)
              : {'error': 'Tidak ada detail error dari server'};
          emit(UserFailure(error: errorData['error'] ?? 'User gagal'));
        }
      } catch (e) {
        print('Error: $e');
        emit(UserFailure(error: 'Terjadi kesalahan, coba lagi.'));
      }
    });
  }
}



// class UserBloc extends Bloc<dynamic, UserState> {
//   final LoginBloc loginBloc;

//   UserBloc({required this.loginBloc}) : super(UserLoading()) {
//     // Dengarkan perubahan pada loginBloc
//     loginBloc.stream.listen((state) {
//       if (state is LoginSuccess) {
//         // Langsung ambil data pengguna saat login berhasil
//         _fetchUser();
//       }
//     });

//     // Jika login sudah berhasil saat inisialisasi
//     if (loginBloc.state is LoginSuccess) {
//       _fetchUser();
//     }
//   }

//   Future<void> _fetchUser() async {
//     emit(UserLoading());
//     try {
//       final token = (loginBloc.state is LoginSuccess)
//           ? (loginBloc.state as LoginSuccess).token
//           : null;

//       if (token == null) {
//         emit(UserFailure(error: 'Token tidak ada'));
//         return;
//       }

//       print('Token: $token');

//       final response = await http.get(
//         Uri.parse('https://cc31-36-85-35-19.ngrok-free.app/users'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         emit(UserSuccess(data: data));
//       } else {
//         final errorData = response.body.isNotEmpty
//             ? jsonDecode(response.body)
//             : {'error': 'Tidak ada detail error dari server'};
//         emit(UserFailure(error: errorData['error'] ?? 'User gagal'));
//       }
//     } catch (e) {
//       print('Error: $e');
//       emit(UserFailure(error: 'Terjadi kesalahan, coba lagi.'));
//     }
//   }
// }






// import 'package:bloc/bloc.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:rentcost/features/users/bloc/user_state.dart';
// import 'package:rentcost/features/users/bloc/user_event.dart';

// class UserBloc extends Bloc<UserEvent, UserState> {
//   UserBloc() : super(UserInitial()) {
//     on<UserRequest>(_onUserRequest);
//   }

//   Future<void> _onUserRequest(
//       UserRequest event, Emitter<UserState> emit) async {
//     emit(UserLoading());
//     try {
//       final response = await http.post(
//         Uri.parse('https://e050-36-85-34-198.ngrok-free.app/users'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'username': event.username,
//           'email': event.email,
//           'phone_number': event.phone_number,
//         }),
//       );

//       if (response.statusCode == 201) {
//         final data = jsonDecode(response.body);
//         final message = data['message'];
//         print(message);
//         emit(UserSuccess(data: data));
//       } else {
//         final errorData = response.body.isNotEmpty
//             ? jsonDecode(response.body)
//             : {'error': 'Tidak ada detail error dari server'};
//         emit(UserFailure(error: errorData['error'] ?? 'User gagal'));
//       }
//     } catch (e) {
//       print(e);
//       emit(UserFailure(error: 'Terjadi kesalahan, coba lagi.'));
//     }
//   }
// }
