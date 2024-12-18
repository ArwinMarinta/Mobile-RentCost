import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rentcost/features/Authentication/Login/bloc/login_bloc.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_state.dart';
import 'package:rentcost/config/config.dart';
import 'package:rentcost/features/stores/model/product.dart';
import 'package:rentcost/features/users/bloc/user_product_event.dart';
import 'package:rentcost/features/users/bloc/user_product_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductUserBloc extends Bloc<ProductUserEvent, ProductUserState> {
  ProductUserBloc() : super(ProductUserInitial()) {
    on<ProductUser>(_onProductUser);
    on<UserProductClear>(_onUserProductClear);
  }
  void _onUserProductClear(
      UserProductClear event, Emitter<ProductUserState> emit) {
    emit(ProductUserInitial());
  }

  Future<List<ProductUserRent>> _onProductUser(
      ProductUser event, Emitter<ProductUserState> emit) async {
    emit(ProductUserLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        emit(ProductUserFailure(error: 'Token tidak ada'));
        return Future.error('Token tidak ada');
      }

      final response = await http.get(
        Uri.parse('${UrlApi.baseUrl}/stores/user'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        List<ProductUserRent> list = (data['data'] as List)
            .map((data) => ProductUserRent.fromJson(data))
            .toList();

        if (list.isEmpty) {
          emit(ProductUserFailure(error: "Anda belum memiliki kostum"));
          return [];
        }

        emit(ProductUserLoaded(product: list));
        return list;
      } else {
        final errorData = response.body.isNotEmpty
            ? jsonDecode(response.body)
            : {'error': 'Tidak ada detail error dari server'};
        emit(ProductUserFailure(error: errorData['error'] ?? 'User gagal'));
        return Future.error('Failed to load Searchs');
      }
    } catch (e) {
      print('Error: $e');
      emit(ProductUserFailure(error: "Error while fetching data"));
      return Future.error('Error while fetching data');
    }
  }
}
