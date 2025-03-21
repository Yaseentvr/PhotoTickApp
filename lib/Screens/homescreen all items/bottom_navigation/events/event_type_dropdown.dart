// import 'package:flutter/material.dart';

// class EventTypeDropdown extends StatelessWidget {
//   final String? selectedEventType;
//   final List<String> eventTypes;
//   final ValueChanged<String?> onChanged;

//   const EventTypeDropdown({
//     Key? key,
//     required this.selectedEventType,
//     required this.eventTypes,
//     required this.onChanged,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 6,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: DropdownButton<String>(
//         value: selectedEventType,
//         hint: Text(
//           'Select Event Type',
//           style: TextStyle(fontSize: 16, color: Colors.grey),
//         ),
//         items: eventTypes.map((eventType) {
//           return DropdownMenuItem<String>(
//             value: eventType,
//             child: Text(
//               eventType,
//               style: TextStyle(color: Color(0xFF57CFCE)),
//             ),
//           );
//         }).toList(),
//         onChanged: onChanged,
//         underline: SizedBox(), // Remove the default underline
//         isExpanded: true,
//       ),
//     );
//   }
// }