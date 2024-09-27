import 'package:flutter/material.dart';

import 'package:zenfi/model/payment_model.dart';

class PaymentController extends ChangeNotifier {
  List<PaymentModel> paymentList = [];

  get list => null;

  // Method to fetch payments (simulated for demonstration)
  Future<void> fetchPayments() async {
    // Simulating fetching data from a backend or database
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay

    // Mock data - replace with actual API call or database query
    paymentList = [
      PaymentModel(
        id: 1,
        title: 'Payment 1',
        amount: 100.0,
        date: DateTime.now(),
      ),
      PaymentModel(
        id: 2,
        title: 'Payment 2',
        amount: 150.0,
        date: DateTime.now(),
      ),
      PaymentModel(
        id: 3,
        title: 'Payment 3',
        amount: 200.0,
        date: DateTime.now(),
      ),
    ];

    // Notify listeners to update widgets listening to this controller
    notifyListeners();
  }
}
