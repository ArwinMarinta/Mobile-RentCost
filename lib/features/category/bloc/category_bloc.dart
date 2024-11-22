import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rentcost/config/config.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_bloc.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_state.dart';
import 'package:rentcost/features/category/bloc/category_event.dart';
import 'package:rentcost/features/category/bloc/category_state.dart';
import 'package:rentcost/features/category/model/category_model.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final LoginBloc loginBloc;

  CategoriesBloc({required this.loginBloc}) : super(CategoriesInitial()) {
    on<CategoriesRequest>(_onCategoriesRequest);
  }

  Future<List<Categories>> _onCategoriesRequest(
      CategoriesRequest event, Emitter<CategoriesState> emit) async {
    emit(CategoriesLoading());
    try {
      final token = (loginBloc.state is LoginSuccess)
          ? (loginBloc.state as LoginSuccess).token
          : null;

      if (token == null) {
        emit(CategoriesFailure(error: 'Token tidak ada'));
        return Future.error('Token tidak ada');
      }

      final response = await http.get(
        Uri.parse('${UrlApi.baseUrl}/categories'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        List<Categories> categoriesList = (data['data'] as List)
            .map((data) => Categories.fromJson(data))
            .toList();

        emit(CategoriesLoaded(categories: categoriesList));
        return categoriesList;
      } else {
        final errorData = response.body.isNotEmpty
            ? jsonDecode(response.body)
            : {'error': 'Tidak ada detail error dari server'};
        emit(CategoriesFailure(error: errorData['error'] ?? 'User gagal'));
        return Future.error('Failed to loadCategoriess');
      }
    } catch (e) {
      print('Error kali: $e');
      emit(CategoriesFailure(error: "error"));
      return Future.error('Error while fetching data');
    }
  }
}
