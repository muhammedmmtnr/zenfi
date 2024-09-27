import 'package:flutter/material.dart';

class InvoiceProvider extends ChangeNotifier {
  final customerNameController = TextEditingController();
  final addressController = TextEditingController();
  final itemNameController = TextEditingController();
  final itemPriceController = TextEditingController();
  final itemQuantityController = TextEditingController();
  final advanceController = TextEditingController();
  final discountController = TextEditingController();
}
