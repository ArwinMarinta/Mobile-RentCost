import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rentcost/config/config.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_bloc.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_state.dart';
import 'package:rentcost/features/cart/bloc/cart_event.dart';
import 'package:rentcost/features/cart/bloc/cart_state.dart';
import 'package:rentcost/features/cart/model/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartToItemRequest>(_onCartToItemRequest);
    on<CartRequest>(_onCartRequest);
    on<CartDeleteItem>(_onCartDeleteItem);
    on<CartClear>(_onCartClear);
  }
  void _onCartClear(CartClear event, Emitter<CartState> emit) {
    emit(CartInitial()); // Reset state ke StoreInitial
  }

  Future<void> _onCartToItemRequest(
      CartToItemRequest event, Emitter<CartState> emit) async {
    emit(CartToItemLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        emit(CartToItemFailure(error: 'Token tidak ada'));
        return;
      }

      final id = event.id;

      final response = await http.post(Uri.parse('${UrlApi.baseUrl}/carts/$id'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({'size_id': event.sizeId}));

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        emit(CartToItemSuccess(message: data['message']));
        // add(CategoriesRequest());
      } else {
        emit(CartToItemFailure(error: data['message']));
        print(data['message']);
      }
    } catch (e) {
      emit(CartToItemFailure(error: 'Gagal Menghapus Categories'));
    }
  }

  Future<void> _onCartRequest(
      CartRequest event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        emit(CartToItemFailure(error: 'Token tidak ada'));
        return;
      }

      final response = await http.get(
        Uri.parse('${UrlApi.baseUrl}/carts-item'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        final CartResponse cart = CartResponse.fromJson(data);

        emit(CartLoaded(cart: cart));

        // add(CategoriesRequest());
      } else {
        final errorData = response.body.isNotEmpty
            ? jsonDecode(response.body)
            : {'error': 'Tidak ada detail error dari server'};
        emit(CartFailure(error: errorData['message'] ?? 'User gagal'));
      }
    } catch (e) {
      emit(CartFailure(error: 'Gagal menampilkan keranjang'));
    }
  }

  Future<void> _onCartDeleteItem(
      CartDeleteItem event, Emitter<CartState> emit) async {
    emit(CartDeleteLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        emit(CartDeleteFailure(error: 'Token tidak ada'));
        return;
      }

      final id = event.id;

      final response = await http
          .delete(Uri.parse('${UrlApi.baseUrl}/carts-item/$id'), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        emit(CartDeleteSuccess(message: data['message']));
        // add(CategoriesRequest());
      } else {
        emit(CartDeleteFailure(error: data['message']));
        print(data['message']);
      }
    } catch (e) {
      emit(CartDeleteFailure(error: 'Gagal Menghapus Categories'));
    }
  }
}
