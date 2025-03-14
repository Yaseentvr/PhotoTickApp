import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phototickapp/Screens/client/clientPersonalworksdetails/client_Customs/client_details_showing_container.dart';
import 'package:phototickapp/Screens/client/clientPersonalworksdetails/texts/client_budget_text.dart';
import 'package:phototickapp/Screens/client/clientPersonalworksdetails/texts/client_date_text.dart';
import 'package:phototickapp/Screens/client/clientPersonalworksdetails/texts/client_event_text.dart';
import 'package:phototickapp/Screens/client/clientPersonalworksdetails/texts/client_location_text.dart';
import 'package:phototickapp/Screens/client/clientPersonalworksdetails/texts/client_name_text.dart';
import 'package:phototickapp/Screens/client/clientPersonalworksdetails/texts/client_phone_text.dart';
import 'package:phototickapp/db/client_model/client_model.dart';

class Details extends StatelessWidget {
  final ClientModel clientDetailsClick;
  const Details({super.key, required this.clientDetailsClick});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFFBFB),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFEFFBFB),
        title: Text(
          'CLIENT DETAILS',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 19,
              color: Color(0xFF57CFCE)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              child: Card(
                color: Colors.white,
                shadowColor: (Color.fromARGB(255, 61, 147, 147)),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      clientDateText(clientDetailsClick: clientDetailsClick),
                      clientTimeText(clientDetailsClick: clientDetailsClick),
                      clientNameText(clientDetailsClick: clientDetailsClick),
                      clientLocationText(
                          clientDetailsClick: clientDetailsClick),
                      clientEventText(clientDetailsClick: clientDetailsClick),
                      clientPhoneText(clientDetailsClick: clientDetailsClick),
                      clientBudgetText(clientDetailsClick: clientDetailsClick),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              child: Card(
                color: Colors.white,
                shadowColor: (Color.fromARGB(255, 61, 147, 147)),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(19.0),
                  child: clientDetailsShowing_container(
                    clientDetailsClick: clientDetailsClick,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget clientTimeText({required ClientModel clientDetailsClick}) {
    DateTime parsedTime = DateFormat('HH:mm').parse(clientDetailsClick.time);
    String formattedTime = DateFormat.jm()
        .format(parsedTime); // Convert to 12-hour format with AM/PM

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Time : ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          SizedBox(width: 45),
          Text(
            '$formattedTime',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 61, 147, 147),
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
