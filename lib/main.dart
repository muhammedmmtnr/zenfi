import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:zenfi/domain/models/category_model.dart';
import 'package:zenfi/domain/models/transaction_model.dart';
import 'package:zenfi/presentation/screens/login/login.dart';
import 'package:zenfi/provider/invoiceprovider.dart';
import 'package:zenfi/splash/splashscreen.dart';  

// Add this function to initialize Firebase  
Future<void> main() async {  
  WidgetsFlutterBinding.ensureInitialized();  
  await Firebase.initializeApp();  // Initialize Firebase  
  
  await Hive.initFlutter();  
  Hive.registerAdapter(TransactionAdapter());  
  Hive.registerAdapter(CategoryModelAdapter());  

  await Hive.openBox<Transaction>('transactions');  
  await Hive.openBox<CategoryModel>('categories');  

  runApp(  
    MultiProvider(  
      providers: [  
        ChangeNotifierProvider(create: (_) => InvoiceProvider()),  
      ],  
      child: SplashScreen(),  
    ),  
  );  
}