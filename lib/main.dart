import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_gateway_integration_app/payment_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  Stripe.publishableKey =
      'pk_test_51QpEi4FZ0h4RBRG97kFS9iRHZx3He98KMEoYs3I4HS77CRmuufcttvGvtMXsmpTOoPw15Re3y47H1gRtSmI4Eyzu005Agcll2p';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stripe Gateway',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PaymentScreenPage(),
    );
  }
}
