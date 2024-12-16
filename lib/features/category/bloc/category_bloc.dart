import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rentcost/config/config.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_bloc.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_state.dart';
import 'package:rentcost/features/category/bloc/category_event.dart';
import 'package:rentcost/features/category/bloc/category_state.dart';
import 'package:rentcost/features/category/model/category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitial()) {
    on<CategoriesRequest>(_onCategoriesRequest);
    on<CategoriesCreateEvent>(_onCategorieCreate);
    on<CategoriesDeleteEvent>(_onCategorieDelete);
  }

  Future<List<Categories>> _onCategoriesRequest(
      CategoriesRequest event, Emitter<CategoriesState> emit) async {
    emit(CategoriesLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final tokens = prefs.getString('access_token');

      if (tokens == null) {
        emit(CategoriesFailure(error: 'Token tidak ada'));
        return Future.error('Token tidak ada');
      }

      final response = await http.get(
        Uri.parse('${UrlApi.baseUrl}/categories'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tokens',
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

  Future<void> _onCategorieCreate(
      CategoriesCreateEvent event, Emitter<CategoriesState> emit) async {
    emit(CategoriesCreateLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        emit(CategoriesCreateFailure(error: 'Token tidak ada'));
        return;
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${UrlApi.baseUrl}/categories'),
      );
      request.headers['Authorization'] = 'Bearer $token';

      request.files.add(await http.MultipartFile.fromPath(
        'image_url',
        event.file,
      ));

      request.fields['category_name'] = event.category_name;

      var response = await request.send();

      if (response.statusCode == 201) {
        emit(CategoriesCreateSuccess(message: "Berhasil menambah categories"));
        // add(CategoriesRequest());
      } else {
        emit(CategoriesCreateFailure(error: 'Gagal menambah categories'));
      }
    } catch (e) {
      print('Error: $e');
      emit(CategoriesCreateFailure(error: 'Gagal menambah categories'));
    }
  }

  Future<void> _onCategorieDelete(
      CategoriesDeleteEvent event, Emitter<CategoriesState> emit) async {
    emit(CategoriesDeleteLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        emit(CategoriesCreateFailure(error: 'Token tidak ada'));
        return;
      }

      final categories = event.id;

      final response = await http.delete(
        Uri.parse('${UrlApi.baseUrl}/categories/$categories'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        emit(CategoriesDeleteSuccess(message: "Berhasil menghapus Categories"));
        // add(CategoriesRequest());
      } else {
        emit(CategoriesDeleteFailure(error: 'Gagal Menghapus Categories'));
      }
    } catch (e) {
      emit(CategoriesCreateFailure(error: 'Gagal Menghapus Categories'));
    }
  }
}
