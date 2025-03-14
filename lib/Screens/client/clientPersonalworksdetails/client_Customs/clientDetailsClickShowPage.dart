// import 'package:flutter/material.dart';
// import 'package:phototickapp/Screens/client/clientPersonalworksdetails/client_Customs/client_details_showing_container.dart';
// import 'package:phototickapp/Screens/client/clientPersonalworksdetails/texts/client__link_text.dart';
// import 'package:phototickapp/Screens/client/clientPersonalworksdetails/texts/client_budget_text.dart';
// import 'package:phototickapp/Screens/client/clientPersonalworksdetails/texts/client_date_text.dart';
// import 'package:phototickapp/Screens/client/clientPersonalworksdetails/texts/client_event_text.dart';
// import 'package:phototickapp/Screens/client/clientPersonalworksdetails/texts/client_location_text.dart';
// import 'package:phototickapp/Screens/client/clientPersonalworksdetails/texts/client_name_text.dart';
// import 'package:phototickapp/Screens/client/clientPersonalworksdetails/texts/client_phone_text.dart';
// import 'package:phototickapp/Screens/client/clientPersonalworksdetails/texts/client_time_text.dart';
// import 'package:phototickapp/db/client%20model/client_model.dart';
// import 'package:phototickapp/screen%20Sizes/screenSize.dart';

// class ClientdetailsPage extends StatelessWidget {
//   // model vach datas pass cheyyunnu

//   final ClientModel clientDetailsClick;
 
  
  

//   const ClientdetailsPage({
//     super.key,
//     required this.clientDetailsClick, 
//   });

//   @override
//   Widget build(BuildContext context) {
//     Screensize();
//     return Scaffold(
//       backgroundColor: Color(0xFFEFFBFB),
//       appBar: AppBar(
//         backgroundColor: Color(0xFFEFFBFB),
//       ),
//       body: SingleChildScrollView(
//         // child: clientDetailsTexts(clientDetailsClick: clientDetailsClick, ),
//       ),
//     );
//   }
// }

// class clientDetailsTexts extends StatelessWidget {
//   const clientDetailsTexts({
//     super.key,
//     required this.clientDetailsClick, 
    
//   });

//   final ClientModel clientDetailsClick;
  


//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(
//               top: 20,
//               left: 10,
//               right: 10), // Remove bottom padding from this card
//           child: Card(
//             color: Colors.white,
//             shadowColor: (Color.fromARGB(255, 61, 147, 147)),
//             elevation: 5,
//             child: Padding(
//               padding: const EdgeInsets.all(25.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   clientDateText(clientDetailsClick: clientDetailsClick),
//                   clientTimeText(clientDetailsClick: clientDetailsClick),
//                   clientNameText(clientDetailsClick: clientDetailsClick),
//                   clientLocationText(clientDetailsClick: clientDetailsClick),
//                   clientEventText(clientDetailsClick: clientDetailsClick),
//                   clientPhoneText(clientDetailsClick: clientDetailsClick),
//                   clientBudgetText(clientDetailsClick: clientDetailsClick),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(
//               top: 20, left: 10, right: 10), // Add spacing
//           child: Card(
//             color: Colors.white,
//             shadowColor: (Color.fromARGB(255, 61, 147, 147)),
//             elevation: 5,
//             child: Padding(
//               padding: const EdgeInsets.all(19.0),
//               child: clientDetailsShowing_container(
//                   clientDetailsClick: clientDetailsClick,
                  
//                   ),
//             ),
//           ),
//         ),
//         client_Link_text(
         
//         ),
//       ],
//     );
//   }
// }
