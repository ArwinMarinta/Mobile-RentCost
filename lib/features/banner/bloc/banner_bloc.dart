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

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final LoginBloc loginBloc;

  BannerBloc({required this.loginBloc}) : super(BannerInitial()) {
    on<BannerRequest>(_onBannerRequest);
  }

  Future<List<BannerResponse>> _onBannerRequest(
      BannerRequest event, Emitter<BannerState> emit) async {
    print("tevsasas");
    emit(BannerLoading());
    try {
      print("seidky");
      final token = (loginBloc.state is LoginSuccess)
          ? (loginBloc.state as LoginSuccess).token
          : null;

      if (token == null) {
        emit(BannerFailure(error: 'Token tidak ada')); 
        return Future.error(
            'Token tidak ada'); 
      }

      final response = await http.get(
        Uri.parse('${UrlApi.baseUrl}/banners'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
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
}
