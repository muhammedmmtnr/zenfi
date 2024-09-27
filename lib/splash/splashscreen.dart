import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:zenfi/presentation/screens/login/login.dart';
import 'package:zenfi/presentation/widgets/bottom_navbar.dart';
import 'package:zenfi/provider/invoiceprovider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Use the WidgetsBinding.instance?.addPostFrameCallback to ensure the context is available
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final invoiceProvider =
          Provider.of<InvoiceProvider>(context, listen: false);
      invoiceProvider.customerNameController.clear();
      invoiceProvider.addressController.clear();
      invoiceProvider.itemNameController.clear();
      invoiceProvider.itemPriceController.clear();
      invoiceProvider.itemQuantityController.clear();
      invoiceProvider.advanceController.clear();

      // Navigate to the MainView after a delay
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Bottom()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: 300.0,
          width: 230.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Image.asset(
                    'assets/bill.gif',
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Loading...',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
