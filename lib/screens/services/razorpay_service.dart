import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayService {
  late Razorpay _razorpay;

  RazorPayService() {
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handleSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handleError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleWallet);
  }

  void openPayment({required int amount}) {
    var options = {
      'key': 'rzp_test_ChtIh4impxVRVG', 
      'amount': amount * 100,
      'name': 'Markwave Cart',
      'description': 'Buffalo Purchase',
      'prefill': {
        'contact': '9876543210',
        'email': 'test@gmail.com',
      }
    };

    _razorpay.open(options);
  }

  void dispose() {
    _razorpay.clear();
  }



  void _handleSuccess(PaymentSuccessResponse response) {
    debugPrint("SUCCESS: $response");
  }

  void _handleError(PaymentFailureResponse response) {
    debugPrint("ERROR: $response");
  }

  void _handleWallet(ExternalWalletResponse response) {
    debugPrint("WALLET: $response");
  }
}
