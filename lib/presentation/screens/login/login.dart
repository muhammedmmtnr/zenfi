// import 'package:flutter/cupertino.dart';  
// import 'package:flutter/material.dart';  
// import 'package:flutter/services.dart';  
// import 'package:firebase_auth/firebase_auth.dart';  
// import 'package:zenfi/presentation/widgets/contry_picker.dart';  
// import 'package:zenfi/presentation/widgets/custombutton.dart';  

// class LoginScreen extends StatefulWidget {  
//   @override  
//   _LoginScreenState createState() => _LoginScreenState();  
// }  

// class _LoginScreenState extends State<LoginScreen> {  
//   final _contactEditingController = TextEditingController();  
//   var _dialCode = '';  
//   final FirebaseAuth _auth = FirebaseAuth.instance;  

//   Login click with contact number validation  
//   Future<void> clickOnLogin(BuildContext context) async {  
//     if (_contactEditingController.text.isEmpty) {  
//       showErrorDialog(context, 'Contact number can\'t be empty.');  
//     } else {  
//       // Attempt to sign in the user  
//       try {  
//         final phoneNumber = '$_dialCode${_contactEditingController.text}';  
//         await _auth.verifyPhoneNumber(  
//           phoneNumber: phoneNumber,  
//           verificationCompleted: (PhoneAuthCredential credential) async {  
//             // Auto-retrieve verification code  
//             UserCredential userCredential =  
//                 await _auth.signInWithCredential(credential);  
//             // Navigate to the next screen  
//             Navigator.pushNamed(context, '/homeScreen'); // Update with your home screen route  
//           },  
//           verificationFailed: (FirebaseAuthException e) {  
//             showErrorDialog(context, e.message ?? 'Verification failed.');  
//           },  
//           codeSent: (String verificationId, int? resendToken) {  
//             Navigator.pushNamed(context, '/otpScreen', arguments: verificationId);  
//           },  
//           codeAutoRetrievalTimeout: (String verificationId) {},  
//         );  
//       } catch (e) {  
//         showErrorDialog(context, e.toString());  
//       }  
//     }  
//   }  

//   // Callback function of country picker  
//   void _callBackFunction(String name, String dialCode, String flag) {  
//     _dialCode = dialCode;  
//   }  

//   // Alert dialogue to show error and response  
//   void showErrorDialog(BuildContext context, String message) {  
//     final CupertinoAlertDialog alert = CupertinoAlertDialog(  
//       title: const Text('Error'),  
//       content: Text('\n$message'),  
//       actions: <Widget>[  
//         CupertinoDialogAction(  
//           isDefaultAction: true,  
//           child: const Text('OK'),  
//           onPressed: () {  
//             Navigator.of(context).pop();  
//           },  
//         )  
//       ],  
//     );  
//     showDialog(  
//       context: context,  
//       builder: (BuildContext context) {  
//         return alert;  
//       },  
//     );  
//   }  

//   // Build method for UI representation  
//   @override  
//   Widget build(BuildContext context) {  
//     final screenHeight = MediaQuery.of(context).size.height;  
//     final screenWidth = MediaQuery.of(context).size.width;  
//     return Scaffold(  
//       body: Center(  
//         child: SingleChildScrollView(  
//           child: Container(  
//             padding: const EdgeInsets.all(16.0),  
//             width: double.infinity,  
//             child: Column(  
//               crossAxisAlignment: CrossAxisAlignment.center,  
//               mainAxisAlignment: MainAxisAlignment.center,  
//               children: [  
//                 SizedBox(  
//                   height: screenHeight * 0.05,  
//                 ),  
//                 Image.asset(  
//                   'assets/images/logo.png',  
//                   width: screenWidth * 0.7,  
//                   fit: BoxFit.contain,  
//                 ),  
//                 SizedBox(  
//                   height: screenHeight * 0.05,  
//                 ),  
//                 Image.asset(  
//                   'assets/images/registration.png',  
//                   height: screenHeight * 0.3,  
//                   fit: BoxFit.contain,  
//                 ),  
//                 SizedBox(  
//                   height: screenHeight * 0.02,  
//                 ),  
//                 const Text(  
//                   'Login',  
//                   style: TextStyle(fontSize: 28, color: Colors.black),  
//                 ),  
//                 SizedBox(  
//                   height: screenHeight * 0.02,  
//                 ),  
//                 const Text(  
//                   'Enter your mobile number to receive a verification code',  
//                   textAlign: TextAlign.center,  
//                   style: TextStyle(  
//                     fontSize: 18,  
//                     color: Colors.black,  
//                   ),  
//                 ),  
//                 SizedBox(  
//                   height: screenHeight * 0.04,  
//                 ),  
//                 Container(  
//                   margin: EdgeInsets.symmetric(  
//                       horizontal: screenWidth > 600 ? screenWidth * 0.2 : 16),  
//                   padding: const EdgeInsets.all(16.0),  
//                   decoration: BoxDecoration(  
//                       color: Colors.white,  
//                       boxShadow: [  
//                         const BoxShadow(  
//                           color: Colors.grey,  
//                           offset: Offset(0.0, 1.0),  
//                           blurRadius: 6.0,  
//                         ),  
//                       ],  
//                       borderRadius: BorderRadius.circular(16.0)),  
//                   child: Column(  
//                     children: [  
//                       Container(  
//                         margin: const EdgeInsets.all(8),  
//                         padding: const EdgeInsets.symmetric(horizontal: 8.0),  
//                         height: 45,  
//                         decoration: BoxDecoration(  
//                           border: Border.all(  
//                             color: const Color.fromARGB(255, 253, 188, 51),  
//                           ),  
//                           borderRadius: BorderRadius.circular(36),  
//                         ),  
//                         child: Row(  
//                           children: [  
//                             CountryPicker(  
//                               callBackFunction: _callBackFunction,  
//                               headerText: 'Select Country',  
//                               headerBackgroundColor:  
//                                   Theme.of(context).primaryColor,  
//                               headerTextColor: Colors.white,  
//                             ),  
//                             SizedBox(  
//                               width: screenWidth * 0.01,  
//                             ),  
//                             Expanded(  
//                               child: TextField(  
//                                 decoration: const InputDecoration(  
//                                   hintText: 'Contact Number',  
//                                   border: InputBorder.none,  
//                                   enabledBorder: InputBorder.none,  
//                                   focusedBorder: InputBorder.none,  
//                                   contentPadding:  
//                                       EdgeInsets.symmetric(vertical: 13.5),  
//                                 ),  
//                                 controller: _contactEditingController,  
//                                 keyboardType: TextInputType.number,  
//                                 inputFormatters: [  
//                                   LengthLimitingTextInputFormatter(10)  
//                                 ],  
//                               ),  
//                             ),  
//                           ],  
//                         ),  
//                       ),  
//                       const SizedBox(  
//                         height: 8,  
//                       ),  
//                       CustomButton(clickOnLogin),  
//                     ],  
//                   ),  
//                 )  
//               ],  
//             ),  
//           ),  
//         ),  
//       ),  
//     );  
//   }  
// }