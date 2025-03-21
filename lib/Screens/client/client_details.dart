import 'dart:developer';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:phototickapp/Screens/client/clientpersonal_worksdetails/client_customs/client_details_showing_container.dart';
import 'package:phototickapp/Screens/client/clientpersonal_worksdetails/texts/client_budget_text.dart';
import 'package:phototickapp/Screens/client/clientpersonal_worksdetails/texts/client_date_text.dart';
import 'package:phototickapp/Screens/client/clientpersonal_worksdetails/texts/client_event_text.dart';
import 'package:phototickapp/Screens/client/clientpersonal_worksdetails/texts/client_location_text.dart';
import 'package:phototickapp/Screens/client/clientpersonal_worksdetails/texts/client_name_text.dart';
import 'package:phototickapp/Screens/client/clientpersonal_worksdetails/texts/client_phone_text.dart';
import 'package:phototickapp/colors/colors.dart';
import 'package:phototickapp/db/client_model/client_model.dart';
import 'package:url_launcher/url_launcher.dart';

class Details extends StatefulWidget {
  final ClientModel clientDetailsClick;
  const Details({super.key, required this.clientDetailsClick});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late TextEditingController _driveLinkController;
  late String _savedDriveLink;

  @override
  void initState() {
    super.initState();
    
    _savedDriveLink = widget.clientDetailsClick.driveLink1;
    _driveLinkController = TextEditingController(text: _savedDriveLink);
  }

  @override
  void dispose() {
    _driveLinkController.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor:appBarColor,
        title: Text(
          'CLIENT DETAILS',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 19,
            color: white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              child: Card(
                color: white,
                shadowColor: (Color.fromARGB(255, 61, 147, 147)),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      clientDateText(clientDetailsClick: widget.clientDetailsClick),
                      clientTimeText(clientDetailsClick: widget.clientDetailsClick),
                      clientNameText(clientDetailsClick: widget.clientDetailsClick),
                      clientLocationText(
                          clientDetailsClick: widget.clientDetailsClick),
                      clientEventText(clientDetailsClick: widget.clientDetailsClick),
                      clientPhoneText(clientDetailsClick: widget.clientDetailsClick),
                      clientBudgetText(clientDetailsClick: widget.clientDetailsClick),
                      _buildDriveLinkInput(context),
                      _buildDriveLinkDisplay(context),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              child: Card(
                color: white,
                shadowColor: (Color.fromARGB(255, 61, 147, 147)),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(19.0),
                  child: clientDetailsShowing_container(
                    clientDetailsClick: widget.clientDetailsClick,
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
    String formattedTime = DateFormat.jm().format(parsedTime);

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
              color: grey,
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

   Widget _buildDriveLinkInput(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _driveLinkController,
              decoration: const InputDecoration(
                labelText: 'Drive Link',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              ClipboardData? clipboardData = await Clipboard.getData('text/plain');
              if (clipboardData != null && clipboardData.text != null) {
                setState(() {
                  _driveLinkController.text = clipboardData.text!;
                  _savedDriveLink = _driveLinkController.text;
                  widget.clientDetailsClick.driveLink1 = _savedDriveLink; // Update saved link
                });
                var clientBox = Hive.box<ClientModel>('clientBox');
                 clientBox.put(widget.clientDetailsClick.id, widget.clientDetailsClick);

              }
            },
            icon: const Icon(Icons.paste),
          ),
        ],
      ),
    );
  }

  // Displays the Drive Link and allows launching it
  Widget _buildDriveLinkDisplay(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () async {
          // Ensure the link is well-formed
          String linkToLaunch = _driveLinkController.text.trim();
          if (!linkToLaunch.startsWith('http://') && !linkToLaunch.startsWith('https://')) {
            linkToLaunch = 'https://$linkToLaunch'; // Add HTTPS if missing
          }

          log('Attempting to launch URL: $linkToLaunch');
          final Uri url = Uri.parse(linkToLaunch);

          try {
            if (Theme.of(context).platform == TargetPlatform.android) {
              final intent = AndroidIntent(
                action: 'action_view',
                data: url.toString(),
              );
              await intent.launch();
            } else {
              // For iOS and other platforms
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Could not launch the link')),
                );
              }
            }
          } catch (e) {
            log('Error launching URL: $e');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error launching URL: $e')),
            );
          }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Text(
              'Drive Link: ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color:grey,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                _savedDriveLink,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
