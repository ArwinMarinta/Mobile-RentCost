import 'package:bloc/bloc.dart';
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
}
