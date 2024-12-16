import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rentcost/features/Authentication/Login/bloc/login_bloc.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_state.dart';
import 'package:rentcost/config/config.dart';
import 'package:rentcost/features/address/bloc/address_event.dart';
import 'package:rentcost/features/address/bloc/address_state.dart';
import 'package:rentcost/features/address/model/address_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressInitial()) {
    on<CreateAddress>(_onAddressCreate);
    on<RequestAddress>(_onAddressRequest);
    on<AddressDeleteRequest>(_onAddressDelete);
    on<ShippingAddressUpdate>(_onAddressUpdate);
    on<AddressClear>(_onAddressClear);
  }

  void _onAddressClear(AddressClear event, Emitter<AddressState> emit) {
    emit(AddressInitial()); // Reset state ke StoreInitial
  }

  Future<void> _onAddressCreate(
      CreateAddress event, Emitter<AddressState> emit) async {
    emit(AddressCreateLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        emit(AddressCreateFailure(error: 'Token tidak ada'));
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

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        emit(AddressCreateSuccess(
            message: data['message'] ?? "Berhasil menambah alamat"));
      } else {
        final errorData = response.body.isNotEmpty
            ? jsonDecode(response.body)
            : {'error': 'Tidak ada detail error dari server'};
        emit(AddressCreateFailure(
            error: errorData['error'] ?? 'Gagal menambah alamat'));
      }
    } catch (e) {
      emit(AddressCreateFailure(error: 'Terjadi kesalahan, coba lagi.'));
    }
  }

  Future<List<AddressData>> _onAddressRequest(
      RequestAddress event, Emitter<AddressState> emit) async {
    emit(AddressLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

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
        return addressList;
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

  Future<void> _onAddressDelete(
      AddressDeleteRequest event, Emitter<AddressState> emit) async {
    emit(AddressDeleteLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        emit(AddressDeleteFailure(error: 'Token tidak ada'));
        return Future.error('Token tidak ada');
      }

      final id = event.id;

      final response = await http.delete(
        Uri.parse('${UrlApi.baseUrl}/address/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final accessToken = data['message'];
        emit(AddressDeleteSuccess(message: accessToken));
      } else {
        final errorData = response.body.isNotEmpty
            ? jsonDecode(response.body)
            : {'error': 'Tidak ada detail error dari server'};
        emit(
            AddressDeleteFailure(error: errorData['error'] ?? 'Address gagal'));
      }
    } catch (e) {
      emit(AddressDeleteFailure(error: 'Terjadi kesalahan, coba lagi.'));
    }
  }

  Future<void> _onAddressUpdate(
      ShippingAddressUpdate event, Emitter<AddressState> emit) async {
    emit(AddressDeleteLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        emit(AddressDeleteFailure(error: 'Token tidak ada'));
        return Future.error('Token tidak ada');
      }

      final id = event.id;

      final response = await http.patch(
        Uri.parse('${UrlApi.baseUrl}/address/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final accessToken = data['message'];
        emit(AddressDeleteSuccess(
            message: accessToken ?? "Berhasil mengubah alamat"));
      } else {
        final errorData = response.body.isNotEmpty
            ? jsonDecode(response.body)
            : {'error': 'Tidak ada detail error dari server'};
        emit(
            AddressDeleteFailure(error: errorData['error'] ?? 'Address gagal'));
      }
    } catch (e) {
      emit(AddressDeleteFailure(error: 'Terjadi kesalahan, coba lagi.'));
    }
  }
}
