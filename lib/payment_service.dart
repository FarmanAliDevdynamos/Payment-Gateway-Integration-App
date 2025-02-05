import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentService {
  Future<Map<String, dynamic>?> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, String> body = {
        'amount': ((int.parse(amount)) * 100).toString(), // Convert to cents
        'currency': currency,
        'payment_method_types[]': 'card', // ✅ Fixed issue
      };

      var secretKey = 'Use your own Secret key';
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
