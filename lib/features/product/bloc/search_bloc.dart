import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rentcost/features/Authentication/Login/bloc/login_bloc.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_state.dart';
import 'package:rentcost/config/config.dart';
import 'package:rentcost/features/product/bloc/search_event.dart';
import 'package:rentcost/features/product/bloc/search_state.dart';
import 'package:rentcost/features/product/model/product.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final LoginBloc loginBloc;
  SearchBloc({required this.loginBloc}) : super(SearchInitial()) {
    on<SearchProductEvent>(_onSearchSearch);
    on<SearchResetEvent>((event, emit) {
      emit(SearchInitial());
    });
  }

  Future<List<ProductData>> _onSearchSearch(
      SearchProductEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    try {
      final token = (loginBloc.state is LoginSuccess)
          ? (loginBloc.state as LoginSuccess).token
          : null;

      if (token == null) {
        emit(SearchFailure(error: 'Token tidak ada'));
        return Future.error('Token tidak ada');
      }

      final query = event.search;

      final response = await http.get(
        Uri.parse('${UrlApi.baseUrl}/products/search?search=$query'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        if (query.trim().isEmpty) {
          emit(SearchFailure(error: "Silakan masukkan kata kunci pencarian."));
          return [];
        }
        final Map<String, dynamic> data = jsonDecode(response.body);

        List<ProductData> list = (data['data'] as List)
            .map((data) => ProductData.fromJson(data))
            .toList();

        if (list.isEmpty) {
          emit(SearchFailure(error: "Tidak ada hasil untuk \"$query\""));
          return [];
        }

        emit(SearchProductState(search: list));
        return list;
      } else {
        final errorData = response.body.isNotEmpty
            ? jsonDecode(response.body)
            : {'error': 'Tidak ada detail error dari server'};
        emit(SearchFailure(error: errorData['error'] ?? 'User gagal'));
        return Future.error('Failed to load Searchs');
      }
    } catch (e) {
      print('Error: $e');
      emit(SearchFailure(error: "Error while fetching data"));
      return Future.error('Error while fetching data');
    }
  }
}
