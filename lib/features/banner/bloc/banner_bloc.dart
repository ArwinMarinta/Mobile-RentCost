import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rentcost/config/config.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_bloc.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_state.dart';
import 'package:rentcost/features/banner/bloc/banner_event.dart';
import 'package:rentcost/features/banner/bloc/banner_state.dart';
import 'package:rentcost/features/banner/model/banner_model.dart';
import 'package:rentcost/features/users/bloc/user_event.dart';
import 'package:rentcost/features/users/bloc/user_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannerBloc() : super(BannerInitial()) {
    on<BannerRequest>(_onBannerRequest);
    on<BannerCreateEvent>(_onBannerCreate);
    on<BannerDeleteEvent>(_onBannerDelete);
  }

  Future<List<BannerResponse>> _onBannerRequest(
      BannerRequest event, Emitter<BannerState> emit) async {
    emit(BannerLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final tokens = prefs.getString('access_token');

      if (tokens == null) {
        emit(BannerFailure(error: 'Token tidak ada'));
        return Future.error('Token tidak ada');
      }

      final response = await http.get(
        Uri.parse('${UrlApi.baseUrl}/banners'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tokens',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        print(data);

        List<BannerResponse> bannerList = (data['data'] as List)
            .map((bannerData) => BannerResponse.fromJson(bannerData))
            .toList();

        emit(BannerLoaded(banner: bannerList));
        return bannerList; // Mengembalikan list BannerResponse
      } else {
        final errorData = response.body.isNotEmpty
            ? jsonDecode(response.body)
            : {'error': 'Tidak ada detail error dari server'};
        emit(BannerFailure(error: errorData['error'] ?? 'User gagal'));
        return Future.error('Failed to load banners');
      }
    } catch (e) {
      print('Error: $e');
      emit(BannerFailure(error: "error"));
      return Future.error('Error while fetching data');
    }
  }

  Future<void> _onBannerCreate(
      BannerCreateEvent event, Emitter<BannerState> emit) async {
    emit(BannerCreateLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        emit(BannerCreateFailure(error: 'Token tidak ada'));
        return;
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${UrlApi.baseUrl}/banners'),
      );
      request.headers['Authorization'] = 'Bearer $token';

      request.files.add(await http.MultipartFile.fromPath(
        'image_url',
        event.file,
      ));

      request.fields['banner_name'] = event.banner_name;

      var response = await request.send();

      if (response.statusCode == 201) {
        emit(BannerCreateSuccess(message: "Berhasil menambah banner"));
        // add(BannerRequest());
      } else {
        emit(BannerCreateFailure(error: 'Upload failed'));
      }
    } catch (e) {
      print('Error: $e');
      emit(BannerCreateFailure(error: 'Upload failed'));
    }
  }

  Future<void> _onBannerDelete(
      BannerDeleteEvent event, Emitter<BannerState> emit) async {
    emit(BannerDeleteLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        emit(BannerCreateFailure(error: 'Token tidak ada'));
        return;
      }

      final banner = event.id;

      final response = await http.delete(
        Uri.parse('${UrlApi.baseUrl}/banners/$banner'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        emit(BannerDeleteSuccess(message: "Berhasil menghapus banner"));
        // add(BannerRequest());
      } else {
        emit(BannerDeleteFailure(error: 'Gagal Menghapus Banner'));
      }
    } catch (e) {
      print('Error: $e');
      emit(BannerCreateFailure(error: 'Gagal Menghapus Banner'));
    }
  }
}
