import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rentcost/config/config.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_bloc.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_state.dart';
import 'package:rentcost/features/cart/bloc/cart_event.dart';
import 'package:rentcost/features/cart/bloc/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final LoginBloc loginBloc;

  CartBloc({required this.loginBloc}) : super(CartInitial()) {
    on<CartToItemRequest>(_onCartToItemRequest);
  }

  Future<void> _onCartToItemRequest(
      CartToItemRequest event, Emitter<CartState> emit) async {
    emit(CartToItemLoading());
    try {
      final token = (loginBloc.state is LoginSuccess)
          ? (loginBloc.state as LoginSuccess).token
          : null;

      if (token == null) {
        emit(CartToItemFailure(error: 'Token tidak ada'));
        return;
      }

      final id = event.id;

      print(id);
      print(event.sizeId);

      final response =
          await http.post(Uri.parse('${UrlApi.baseUrl}/carts/${id}'),
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
}
