import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rentcost/features/Authentication/Login/bloc/login_bloc.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_state.dart';
import 'package:rentcost/config/config.dart';
import 'package:rentcost/features/address/bloc/address_event.dart';
import 'package:rentcost/features/address/bloc/address_state.dart';
import 'package:rentcost/features/address/model/address_model.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final LoginBloc loginBloc;
  AddressBloc({required this.loginBloc}) : super(AddressInitial()) {
    on<CreateAddress>(_onAddressCreate);

    on<RequestAddress>(_onAddressRequest);
  }

  Future<void> _onAddressCreate(
      CreateAddress event, Emitter<AddressState> emit) async {
    emit(AddressLoading());
    try {
      final token = (loginBloc.state is LoginSuccess)
          ? (loginBloc.state as LoginSuccess).token
          : null;

      if (token == null) {
        emit(AddressFailure(error: 'Token tidak ada'));
        return Future.error('Token tidak ada');
      }
      final response = await http.post(
        Uri.parse('${UrlApi.baseUrl}/address'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "username": event.username,
          "phone_number": event.phone_number,
          "city": event.city,
          "zip_code": event.zip_code,
          "state": event.state,
          "address1": event.address1,
          "address2": event.address2
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final accessToken = data['message'];
        emit(AddressSuccess(message: accessToken));
      } else {
        final errorData = response.body.isNotEmpty
            ? jsonDecode(response.body)
            : {'error': 'Tidak ada detail error dari server'};
        emit(AddressFailure(error: errorData['error'] ?? 'Address gagal'));
      }
    } catch (e) {
      emit(AddressFailure(error: 'Terjadi kesalahan, coba lagi.'));
    }
  }

  Future<List<AddressData>> _onAddressRequest(
      RequestAddress event, Emitter<AddressState> emit) async {
    emit(AddressLoading());
    try {
      final token = (loginBloc.state is LoginSuccess)
          ? (loginBloc.state as LoginSuccess).token
          : null;

      if (token == null) {
        emit(AddressFailure(error: 'Token tidak ada'));
        return Future.error('Token tidak ada');
      }

      final response = await http.get(
        Uri.parse('${UrlApi.baseUrl}/address'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        List<AddressData> addressList = (data['data'] as List)
            .map((addressData) => AddressData.fromJson(addressData))
            .toList();
        print(addressList);

        emit(AddressLoaded(address: addressList));
        return addressList; // Mengembalikan list AddressResponse
      } else {
        final errorData = response.body.isNotEmpty
            ? jsonDecode(response.body)
            : {'error': 'Tidak ada detail error dari server'};
        emit(AddressFailure(error: errorData['error'] ?? 'User gagal'));
        return Future.error('Failed to load Addresss');
      }
    } catch (e) {
      print('Error: $e');
      emit(AddressFailure(error: "error"));
      return Future.error('Error while fetching data');
    }
  }
}
