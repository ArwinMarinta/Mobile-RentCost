import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rentcost/features/Authentication/Login/bloc/login_bloc.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_state.dart';
import 'package:rentcost/config/config.dart';
import 'package:rentcost/features/stores/bloc/stores_event.dart';
import 'package:rentcost/features/stores/bloc/stores_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final LoginBloc loginBloc;
  StoreBloc({required this.loginBloc}) : super(StoreInitial()) {
    on<StoreCreate>(_onStoreRequest);
    on<ProductCreateEvent>(_onCreateProduct);
    on<StockDelete>(_onStockDelete);
    on<ProductUpdateEvent>(_onUpdateProduct);
    on<StockCreate>(_onCreateStock);
    on<StockUpdate>(_onUpdateStock);
  }

  Future<void> _onStoreRequest(
      StoreCreate event, Emitter<StoreState> emit) async {
    emit(StoreLoading());
    try {
      final token = (loginBloc.state is LoginSuccess)
          ? (loginBloc.state as LoginSuccess).token
          : null;

      if (token == null) {
        emit(StoreFailure(error: 'Token tidak ada'));
        return Future.error('Token tidak ada');
      }
      final response = await http.post(
        Uri.parse('${UrlApi.baseUrl}/stores'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "store_name": event.store_name,
          "store_location": event.store_location
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final accessToken = data['message'];
        emit(StoreSuccess(message: accessToken));
      } else {
        final errorData = response.body.isNotEmpty
            ? jsonDecode(response.body)
            : {'error': 'Tidak ada detail error dari server'};
        emit(StoreFailure(error: errorData['error'] ?? 'Store gagal'));
      }
    } catch (e) {
      emit(StoreFailure(error: 'Terjadi kesalahan, coba lagi.'));
    }
  }

  Future<void> _onCreateProduct(
      ProductCreateEvent event, Emitter<StoreState> emit) async {
    emit(ProductLoadingStore());
    try {
      final token = (loginBloc.state is LoginSuccess)
          ? (loginBloc.state as LoginSuccess).token
          : null;

      if (token == null) {
        emit(ProductFailureStore(error: 'Token tidak ada'));
        return;
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${UrlApi.baseUrl}/products'),
      );
      request.headers['Authorization'] = 'Bearer $token';

      request.files.add(await http.MultipartFile.fromPath(
        'image_url',
        event.imageUrl,
      ));

      request.fields['product_name'] = event.productName;
      request.fields['price'] = event.price.toString();
      request.fields['category_id'] = event.categoryId.toString();
      request.fields['size_stock'] = jsonEncode(event.sizeStock);

      var response = await request.send();

      if (response.statusCode == 201) {
        emit(ProductSuccessStore(message: "Berhasil menambah product"));
        // add(BannerRequest());
      } else {
        emit(ProductFailureStore(error: 'Upload failed'));
      }
    } catch (e) {
      print('Error: $e');
      emit(ProductFailureStore(error: 'Gagal Upload'));
    }
  }

  Future<void> _onStockDelete(
      StockDelete event, Emitter<StoreState> emit) async {
    emit(StockDeleteLoading());
    try {
      final token = (loginBloc.state is LoginSuccess)
          ? (loginBloc.state as LoginSuccess).token
          : null;

      if (token == null) {
        emit(StockUpdateFailure(error: 'Token tidak ada'));
        return;
      }

      final stock = event.id;

      final response = await http.delete(
        Uri.parse('${UrlApi.baseUrl}/stock/${stock}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final message = data['message'];
        emit(StockDeleteSuccess(message: message));
        // add(BannerRequest());
      } else {
        final message = data['error'];
        emit(StockUpdateFailure(error: message));
      }
    } catch (e) {
      print('Error: $e');
      emit(StockUpdateFailure(error: 'Gagal Menghapus Banner'));
    }
  }

  Future<void> _onUpdateProduct(
      ProductUpdateEvent event, Emitter<StoreState> emit) async {
    emit(ProductUpdateLoading());
    try {
      final token = (loginBloc.state is LoginSuccess)
          ? (loginBloc.state as LoginSuccess).token
          : null;

      if (token == null) {
        emit(StockUpdateFailure(error: 'Token tidak ada'));
        return;
      }

      final id = event.id;

      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse('${UrlApi.baseUrl}/products/${id}'),
      );
      request.headers['Authorization'] = 'Bearer $token';

      if (event.imageUrl != event.oldImageUrl) {
        request.files.add(await http.MultipartFile.fromPath(
          'image_url',
          event.imageUrl,
        ));
      } else {
        request.fields['image_url'] = event.oldImageUrl;
      }

      request.fields['product_name'] = event.productName;
      request.fields['price'] = event.price.toString();
      request.fields['category_id'] = event.categoryId.toString();

      var response = await request.send().timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        var data = jsonDecode(await response.stream.bytesToString());
        print(data);
        var message = data['message'];
        emit(StockUpdateSuccess(message: message));
        // add(BannerRequest());
      } else {
        var error = await response.stream.bytesToString();
        print(error);
        emit(ProductUpdateFailure(error: error));
      }
    } catch (e) {
      print('Error: $e');
      emit(ProductUpdateFailure(error: 'Gagal mengubah kostum'));
    }
  }

  Future<void> _onCreateStock(
      StockCreate event, Emitter<StoreState> emit) async {
    emit(StockCreateLoading());
    try {
      final token = (loginBloc.state is LoginSuccess)
          ? (loginBloc.state as LoginSuccess).token
          : null;

      if (token == null) {
        emit(StockCreateFailure(error: 'Token tidak ada'));
        return;
      }

      final id = event.id;

      final response = await http.post(
        Uri.parse('${UrlApi.baseUrl}/stock/${id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({"size_id": event.sizeId, "stok": event.stok}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        final message = data['message'];
        emit(StockCreateSuccess(message: message));
        // add(BannerRequest());
      } else {
        final message = data['error'];
        emit(StockCreateFailure(error: message));
      }
    } catch (e) {
      print('Error: $e');
      emit(StockCreateFailure(error: 'Gagal Menghapus Banner'));
    }
  }

  Future<void> _onUpdateStock(
      StockUpdate event, Emitter<StoreState> emit) async {
    emit(StockUpdateLoading());
    try {
      final token = (loginBloc.state is LoginSuccess)
          ? (loginBloc.state as LoginSuccess).token
          : null;

      if (token == null) {
        emit(StockUpdateFailure(error: 'Token tidak ada'));
        return;
      }

      final id = event.id;

      final response = await http.patch(
        Uri.parse('${UrlApi.baseUrl}/stock/${id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({"size_id": event.sizeId, "stok": event.stok}),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final message = data['message'];
        emit(StockUpdateSuccess(message: message));
        // add(BannerRequest());
      } else {
        final message = data['error'];
        emit(StockUpdateFailure(error: message));
      }
    } catch (e) {
      print('Error: $e');
      emit(StockUpdateFailure(error: 'Gagal Menghapus Banner'));
    }
  }
}
