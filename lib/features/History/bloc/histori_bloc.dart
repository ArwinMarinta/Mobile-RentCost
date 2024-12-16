import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rentcost/config/config.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_bloc.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_state.dart';
import 'package:rentcost/features/History/bloc/histori_event.dart';
import 'package:rentcost/features/History/bloc/histori_state.dart';
import 'package:rentcost/features/History/model/histori.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoriBloc extends Bloc<HistoriEvent, HistoriState> {
  HistoriBloc() : super(HistoriInitial()) {
    // on<HistoriUserRequest>(_onHistoriUser);
    on<HistoriTenantRequest>(_onHistoriTenant);
    // on<PostRatingRequest>(_onPostRating);
    on<HistoriTenantClear>(_onHistoriTenantClear);
  }

  void _onHistoriTenantClear(
      HistoriTenantClear event, Emitter<HistoriState> emit) {
    emit(HistoriInitial()); // Reset state ke StoreInitial
  }

  // Future<void> _onHistoriUser(
  //     HistoriUserRequest event, Emitter<HistoriState> emit) async {
  //   emit(HistoriUserLoading());
  //   try {
  //     final token = (loginBloc.state is LoginSuccess)
  //         ? (loginBloc.state as LoginSuccess).token
  //         : null;

  //     if (token == null) {
  //       emit(HistoriUserFailure(error: 'Token tidak ada'));
  //       return Future.error('Token tidak ada');
  //     }

  //     final response = await http.get(
  //       Uri.parse('${UrlApi.baseUrl}/transactions/user'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> data = jsonDecode(response.body);

  //       final HistoryResponse cart = HistoryResponse.fromJson(data);

  //       print(cart);

  //       if (cart.data.isEmpty) {
  //         emit(HistoriUserFailure(
  //             error:
  //                 "Belum ada riwayat transaksi")); // State baru untuk menandakan tidak ada data
  //       }

  //       emit(HistoriUserLoaded(history: cart));
  //     } else {
  //       emit(HistoriUserFailure(error: "Tidak ada riwayat transaksi"));
  //       return Future.error('Failed to loadCategoriess');
  //     }
  //   } catch (e) {
  //     print('Error kali: $e');
  //     emit(HistoriUserFailure(error: "error"));
  //     return Future.error('Error while fetching data');
  //   }
  // }

  Future<void> _onHistoriTenant(
      HistoriTenantRequest event, Emitter<HistoriState> emit) async {
    emit(HistoriTenantLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        emit(HistoriTenantFailure(error: 'Token tidak ada'));
        return Future.error('Token tidak ada');
      }

      final response = await http.get(
        Uri.parse('${UrlApi.baseUrl}/transactions/tenant'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        final HistoryResponse cart = HistoryResponse.fromJson(data);

        print(cart);

        if (cart.data.isEmpty) {
          emit(HistoriTenantFailure(
              error:
                  "Belum ada riwayat transaksi")); // State baru untuk menandakan tidak ada data
        }

        emit(HistoriTenantLoaded(history: cart));
      } else {
        emit(HistoriTenantFailure(error: "Tidak ada riwayat transaksi"));
        return Future.error('Failed to loadCategoriess');
      }
    } catch (e) {
      print('Error kali: $e');
      emit(HistoriTenantFailure(error: "error"));
      return Future.error('Error while fetching data');
    }
  }

  // Future<void> _onPostRating(
  //     PostRatingRequest event, Emitter<HistoriState> emit) async {
  //   emit(RatingProductLoading());
  //   try {
  //     final token = (loginBloc.state is LoginSuccess)
  //         ? (loginBloc.state as LoginSuccess).token
  //         : null;

  //     if (token == null) {
  //       emit(RatingProductFailure(error: 'Token tidak ada'));
  //       return Future.error('Token tidak ada');
  //     }

  //     final response = await http.post(
  //       Uri.parse('${UrlApi.baseUrl}/products/rating'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //       body: jsonEncode({
  //         'total_rating': event.totalRating,
  //         'product_id': event.productId,
  //         'transactiId': event.transactiId
  //       }),
  //     );

  //     if (response.statusCode == 201) {
  //       emit(RatingProductSuccess(message: "Berhail memberi rating"));
  //     } else {
  //       emit(RatingProductFailure(error: "Tidak ada riwayat transaksi"));
  //       return Future.error('Failed to loadCategoriess');
  //     }
  //   } catch (e) {
  //     print('Error kali: $e');
  //     emit(RatingProductFailure(error: "error"));
  //     return Future.error('Error while fetching data');
  //   }
  // }

  Future<void> _onUpdateStatus(
      UpdateStatusRequest event, Emitter<HistoriState> emit) async {
    emit(UpdateStatusLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        emit(UpdateStatusFailure(error: 'Token tidak ada'));
        return Future.error('Token tidak ada');
      }

      final response = await http.patch(
        Uri.parse('${UrlApi.baseUrl}/products/transaction'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'transaction_id': event.transaction_id,
          'status': event.status,
        }),
      );

      if (response.statusCode == 200) {
        emit(UpdateStatusSuccess(message: "Berhail mengubah status"));
      } else {
        emit(UpdateStatusFailure(error: "Gagal Mengubah status"));
        return Future.error('Failed to loadCategoriess');
      }
    } catch (e) {
      print('Error kali: $e');
      emit(UpdateStatusFailure(error: "error"));
      return Future.error('Error while fetching data');
    }
  }
}
