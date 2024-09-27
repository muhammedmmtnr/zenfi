import 'package:flutter/material.dart';
import 'package:zenfi/model/drawermodel.dart';

class DrawersController {
  final drawer = [
    DrawerModel('Home', Icons.home),
    DrawerModel('Invoice', Icons.receipt_long),
    DrawerModel('Payment', Icons.account_balance),
    DrawerModel('Profile', Icons.person),
    // DrawerModel('Share App', Icons.share),
  ];
}
