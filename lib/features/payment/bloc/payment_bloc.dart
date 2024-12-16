import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:rentcost/config/config.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_bloc.dart';
import 'package:rentcost/features/Authentication/Login/bloc/login_state.dart';
import 'package:rentcost/features/payment/bloc/payment_event.dart';
import 'package:rentcost/features/payment/bloc/payment_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    on<PaymentRequest>(_onPaymentRequest);
  }

  Future<void> _onPaymentRequest(
      PaymentRequest event, Emitter<PaymentState> emit) async {
    emit(PaymentLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) {
        emit(PaymentFailure(error: 'Token tidak ada'));
        return Future.error('Token tidak ada');
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${UrlApi.baseUrl}/transactions'),
      );
      request.headers['Authorization'] = 'Bearer $token';

      request.files.add(await http.MultipartFile.fromPath(
        'payment_image',
        event.paymentImage,
      ));

      request.fields['price'] = event.price;
      request.fields['productId'] = event.productId;

      var response = await request.send();

      if (response.statusCode == 201) {
        emit(PaymentSuccessEvent(message: "Berhasil melakukan pembayaran"));
      } else {
        emit(PaymentFailure(error: "Gagal melalukan pembayaran"));
      }
    } catch (e) {
      emit(PaymentFailure(error: 'Terjadi kesalahan, coba lagi.'));
    }
  }
}
