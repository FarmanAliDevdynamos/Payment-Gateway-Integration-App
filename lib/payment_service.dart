import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentService {
  Future<Map<String, dynamic>?> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, String> body = {
        'amount': ((int.parse(amount)) * 100).toString(), 
        'currency': currency,
        'payment_method_types[]': 'card', 
      };

      var secretKey =
          'sk_test_51QpEi4FZ0h4RBRG9DG1c3GaSBtqYbBCTikkJyIHMEr7sDjdzc7ugSJDABTClouANuRkDNnUwvnrXIhKe1eB4JKf400kqF1bu8c';
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );

      return jsonDecode(response.body);
    } catch (e) {
      print("Error creating PaymentIntent: $e");
      return null;
    }
  }
}
