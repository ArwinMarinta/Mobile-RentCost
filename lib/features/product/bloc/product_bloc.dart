import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rentcost/features/Authentication/Login/bloc/login_bloc.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_state.dart';
import 'package:rentcost/config/config.dart';
import 'package:rentcost/features/product/bloc/product_event.dart';

import 'package:rentcost/features/product/bloc/product_state.dart';
import 'package:rentcost/features/product/model/product.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final LoginBloc loginBloc;
  ProductBloc({required this.loginBloc}) : super(ProductInitial()) {
    on<ProductFilter>(_onProductFilter);
    // on<ProductSearch>(_onProductSearch);
  }

  Future<void> _onProductFilter(
      ProductFilter event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final token = (loginBloc.state is LoginSuccess)
          ? (loginBloc.state as LoginSuccess).token
          : null;

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

  // Future<List<ProductData>> _onProductSearch(
  //     ProductSearch event, Emitter<ProductState> emit) async {
  //   emit(ProductLoading());
  //   try {
  //     final token = (loginBloc.state is LoginSuccess)
  //         ? (loginBloc.state as LoginSuccess).token
  //         : null;

  //     if (token == null) {
  //       emit(ProductFailure(error: 'Token tidak ada'));
  //       return Future.error('Token tidak ada');
  //     }

  //     final query = event.search;

  //     final response = await http.get(
  //       Uri.parse('${UrlApi.baseUrl}/products/search?search=$query'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> data = jsonDecode(response.body);

  //       List<ProductData> list = (data['data'] as List)
  //           .map((data) => ProductData.fromJson(data))
  //           .toList();

  //       if (list.isEmpty) {
  //         emit(ProductFailure(error: "Tidak ada hasil untuk \"$query\""));
  //         return [];
  //       }

  //       emit(ProductSearchState(search: list));
  //       return list;
  //     } else {
  //       final errorData = response.body.isNotEmpty
  //           ? jsonDecode(response.body)
  //           : {'error': 'Tidak ada detail error dari server'};
  //       emit(ProductFailure(error: errorData['error'] ?? 'User gagal'));
  //       return Future.error('Failed to load products');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     emit(ProductFailure(error: "Error while fetching data"));
  //     return Future.error('Error while fetching data');
  //   }
  // }

  // Future<List<ProductData>> _onProductNews(
  //     ProductNews event, Emitter<ProductState> emit) async {
  //   emit(ProductLoading());
  //   try {
  //     final token = (loginBloc.state is LoginSuccess)
  //         ? (loginBloc.state as LoginSuccess).token
  //         : null;

  //     if (token == null) {
  //       emit(ProductFailure(error: 'Token tidak ada'));
  //       return Future.error('Token tidak ada');
  //     }

  //     final response = await http.get(
  //       Uri.parse('${UrlApi.baseUrl}/products/search?filter=news'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> data = jsonDecode(response.body);

  //       List<ProductData> list = (data['data'] as List)
  //           .map((data) => ProductData.fromJson(data))
  //           .toList();

  //       emit(ProductNewsState(news: list));
  //       return list;
  //     } else {
  //       final errorData = response.body.isNotEmpty
  //           ? jsonDecode(response.body)
  //           : {'error': 'Tidak ada detail error dari server'};
  //       emit(ProductFailure(error: errorData['error'] ?? 'User gagal'));
  //       return Future.error('Failed to load Addresss');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     emit(ProductFailure(error: "error"));
  //     return Future.error('Error while fetching data');
  //   }
  // }
}
