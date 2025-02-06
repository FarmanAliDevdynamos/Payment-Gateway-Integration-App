import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_gateway_integration_app/payment_service.dart';

class PaymentScreenPage extends StatefulWidget {
  const PaymentScreenPage({super.key});

  @override
  State<PaymentScreenPage> createState() => _PaymentScreenPageState();
}

class _PaymentScreenPageState extends State<PaymentScreenPage> {
  Map<String, dynamic>? paymentIntent;
  PaymentService paymentService = PaymentService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Stripe Payment Gateway',
          style: TextStyle(
              fontSize: 23, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await makePayment();
          },
          child: Text('PAY NOW'),
        ),
      ),
    );
  }

  // Make Payment Method
  Future<void> makePayment() async {
    try {
      paymentIntent = await paymentService.createPaymentIntent(
          "20", 'GBP'); // Fixed currency code
      if (paymentIntent == null) {
        print("Failed to create Payment Intent");
        return;
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret:
              paymentIntent!['client_secret'], // Fixed key name
          googlePay: PaymentSheetGooglePay(
              testEnv: true, currencyCode: "GBP", merchantCountryCode: "UK"),
          merchantDisplayName: "Farman_Enterprises",
        ),
      );

      // Display Payment Sheet
      await displayPaymentSheet();
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text('Paid Successfully'),
        ),
      );
    } on StripeException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text('Payment Failed: ${e.error.localizedMessage}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment Failed')),
      );
      print('Error: $e');
    }
  }
}
