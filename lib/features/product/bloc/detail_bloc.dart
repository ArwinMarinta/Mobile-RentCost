import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rentcost/features/Authentication/Login/bloc/login_bloc.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_state.dart';
import 'package:rentcost/config/config.dart';
import 'package:rentcost/features/product/bloc/detail_event.dart';
import 'package:rentcost/features/product/bloc/detail_state.dart';
import 'package:rentcost/features/product/model/detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(DetailInitial()) {
    on<DetailProduct>(_onDetailProduct);
  }

  Future<ProductDetailModel> _onDetailProduct(
      DetailProduct event, Emitter<DetailState> emit) async {
    emit(DetailLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        emit(DetailFailure(error: 'Token tidak ada'));
        return Future.error('Token tidak ada');
      }

      final id = event.id;

      final response = await http.get(
        Uri.parse('${UrlApi.baseUrl}/products/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final productDetail = ProductDetailModel.fromJson(jsonData);
        emit(DetailProductState(detail: productDetail));
        return productDetail;
      } else {
        final errorData = response.body.isNotEmpty
            ? jsonDecode(response.body)
            : {'error': 'Tidak ada detail error dari server'};
        emit(DetailFailure(error: errorData['error'] ?? 'User gagal'));
        return Future.error('Failed to load Details');
      }
    } catch (e) {
      print('Error: $e');
      emit(DetailFailure(error: "Error while fetching data"));
      return Future.error('Error while fetching data');
    }
  }
}
