import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rentcost/features/Authentication/Login/bloc/login_bloc.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_state.dart';
import 'package:rentcost/config/config.dart';
import 'package:rentcost/features/product/bloc/product_event.dart';

import 'package:rentcost/features/product/bloc/product_state.dart';
import 'package:rentcost/features/product/model/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductFilter>(_onProductFilter);
    on<ProductDeleteRequest>(_onProductDelete);
  }

  Future<void> _onProductFilter(
      ProductFilter event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        emit(ProductFailure(error: 'Token tidak ada'));
        return Future.error('Token tidak ada');
      }

      // Memulai dua request API secara bersamaan menggunakan Future.wait
      final responses = await Future.wait([
        http.get(
          Uri.parse('${UrlApi.baseUrl}/products/search?filter=populer'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        http.get(
          Uri.parse('${UrlApi.baseUrl}/products/search?filter=news'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      ]);

      final responsePopuler = responses[0];
      final responseTerbaru = responses[1];

      print(responsePopuler);

      if (responsePopuler.statusCode == 200 &&
          responseTerbaru.statusCode == 200) {
        final Map<String, dynamic> dataPopuler =
            jsonDecode(responsePopuler.body);
        List<ProductData> populerList = (dataPopuler['data'] as List)
            .map((data) => ProductData.fromJson(data))
            .toList();

        final Map<String, dynamic> dataTerbaru =
            jsonDecode(responseTerbaru.body);
        List<ProductData> terbaruList = (dataTerbaru['data'] as List)
            .map((data) => ProductData.fromJson(data))
            .toList();

        emit(ProductFilters(populer: populerList, news: terbaruList));
      } else {
        final errorData = responsePopuler.body.isNotEmpty
            ? jsonDecode(responsePopuler.body)
            : {'error': 'Tidak ada detail error dari server'};

        emit(ProductFailure(error: errorData['error'] ?? 'Gagal memuat data'));
        return Future.error('Failed to load Products');
      }
    } catch (e) {
      print('Error: $e');
      emit(ProductFailure(error: "error"));
      return Future.error('Error while fetching data');
    }
  }

  Future<void> _onProductDelete(
      ProductDeleteRequest event, Emitter<ProductState> emit) async {
    emit(ProductDeleteLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        emit(ProductDeleteFailure(error: 'Token tidak ada'));
        return;
      }

      final id = event.id;

      final response = await http.delete(
        Uri.parse('${UrlApi.baseUrl}/products/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        emit(ProductDeleteSuccess(message: data['message']));
        // add(BannerRequest());
      } else {
        emit(ProductDeleteFailure(error: data['error']));
      }
    } catch (e) {
      print('Error: $e');
      emit(ProductDeleteFailure(error: 'Gagal Menghapus Banner'));
    }
  }
}
