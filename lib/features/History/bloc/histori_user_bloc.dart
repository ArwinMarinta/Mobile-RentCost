import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rentcost/config/config.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_bloc.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_state.dart';
import 'package:rentcost/features/History/bloc/histori_user_event.dart';
import 'package:rentcost/features/History/bloc/histori_user_state.dart';
import 'package:rentcost/features/History/model/histori.dart';
import 'package:rentcost/features/History/model/histori_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoriUserBloc extends Bloc<HistoriUserEvent, HistoriUserState> {
  HistoriUserBloc() : super(HistoriUserInitial()) {
    on<HistoriUserUserRequest>(_onHistoriUser);
    on<PostRatingRequest>(_onPostRating);
    on<HistoriUserClear>(_onHistoriUserClear);
  }

  void _onHistoriUserClear(
      HistoriUserClear event, Emitter<HistoriUserState> emit) {
    emit(HistoriUserInitial()); // Reset state ke StoreInitial
  }

  Future<void> _onHistoriUser(
      HistoriUserUserRequest event, Emitter<HistoriUserState> emit) async {
    // Perbaiki tipe generic di sini
    emit(HistoriUserLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        emit(HistoriUserFailure(error: 'Token tidak ada'));
        return Future.error('Token tidak ada');
      }

      final response = await http.get(
        Uri.parse('${UrlApi.baseUrl}/transactions/user'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        final HistoryResponseUser cart = HistoryResponseUser.fromJson(data);

        print(cart);

        if (cart.data.isEmpty) {
          emit(HistoriUserFailure(
              error:
                  "Belum ada riwayat transaksi")); // State baru untuk menandakan tidak ada data
        } else {
          emit(HistoriUserLoaded(history: cart));
        }
      } else {
        emit(HistoriUserFailure(error: "Tidak ada riwayat transaksi"));
        return Future.error('Failed to load transactions');
      }
    } catch (e) {
      print('Error kali: $e');
      emit(HistoriUserFailure(error: "Error while fetching data"));
      return Future.error('Error while fetching data');
    }
  }

  Future<void> _onPostRating(
      PostRatingRequest event, Emitter<HistoriUserState> emit) async {
    emit(RatingProductLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        emit(RatingProductFailure(error: 'Token tidak ada'));
        return Future.error('Token tidak ada');
      }

      final response = await http.post(
        Uri.parse('${UrlApi.baseUrl}/products/rating'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'total_rating': event.totalRating,
          'product_id': event.productId,
          'transactiId': event.transactiId
        }),
      );

      if (response.statusCode == 201) {
        emit(RatingProductSuccess(message: "Berhail memberi rating"));
      } else {
        emit(RatingProductFailure(error: "Tidak ada riwayat transaksi"));
        return Future.error('Failed to loadCategoriess');
      }
    } catch (e) {
      print('Error kali: $e');
      emit(RatingProductFailure(error: "error"));
      return Future.error('Error while fetching data');
    }
  }
}
