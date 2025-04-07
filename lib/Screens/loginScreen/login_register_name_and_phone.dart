// import 'package:flutter/material.dart';
// import 'package:phototickapp/Screens/splash_screens/secondsplash.dart';
// import 'package:phototickapp/colors/colors.dart';
// import 'package:phototickapp/custom/customButton/customButton.dart';
// import 'package:phototickapp/custom/customwidget/textfield.dart';
// import 'package:phototickapp/db/assistants_function/db_function.dart';
// import 'package:phototickapp/db/client_model/client_model.dart';
// import 'package:phototickapp/db/login_function/login_function.dart';
// import 'package:phototickapp/db/login_model/login_%20model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LoginRegisterNameAndPhone extends StatelessWidget {
//   final ClientModel clientCheck;
//   const LoginRegisterNameAndPhone({
//     super.key,
//     required TextEditingController loginNameController,
//     required TextEditingController loginPhoneController,
//     required this.clientCheck,
//   })  : _loginNameController = loginNameController,
//         _loginPhoneController = loginPhoneController;

//   final TextEditingController _loginNameController;
//   final TextEditingController _loginPhoneController;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: Card(
//         child: Padding(
//           padding:
//               const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 20),
//           child: Column(
//             children: [
//               Text(
//                 'Please Enter Your Details',
//                 style: TextStyle(color: black, fontSize: 20),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               CustomTextfield(
//                 color1: white,
//                 hintText: 'Company Name',
//                 controller: _loginNameController,
//                 keyboardType: TextInputType.name,
//                 keybordTpe: TextInputType.text,
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               CustomTextfield(
//                 color1: white,
//                 hintText: 'Company Number',
//                 controller: _loginPhoneController,
//                 keyboardType: TextInputType.phone,
//                 keybordTpe: TextInputType.text,
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               InkWell(
//                 onTap: () async {
//                   String name = _loginNameController.text;
//                   String phone = _loginPhoneController.text;

//                   // Check if the name and phone are already stored
//                   SharedPreferences prefs =
//                       await SharedPreferences.getInstance();
//                   bool isRegistered = prefs.getBool('isRegistered') ?? false;

//                   if (!isRegistered) {
//                     // Store the name and phone number
//                     await prefs.setString('userName', name);
//                     await prefs.setString('userPhone', phone);
//                     await prefs.setBool('isRegistered', true);

//                     final user = Loginmodel(
//                       id: randomId(),
//                       loginName: name,
//                       loginPhone: phone,
//                     );
//                     addLoginDetail(user);
//                   }

//                   // Navigate to home screen directly
//                   Navigator.of(context).pushReplacement(
//                     MaterialPageRoute(
//                       builder: (context) {
//                         return Secondsplash(
//                             name: name, phone: phone, clientCheck: clientCheck);
//                       },
//                     ),
//                   );
//                 },
//                 child: Custombutton(
//                   textColor: white,
//                   backgroundColor: appBarColor,
//                   text: 'Save',
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
