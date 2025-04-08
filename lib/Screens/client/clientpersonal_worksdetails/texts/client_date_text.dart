import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phototickapp/colors/colors.dart';
import 'package:phototickapp/db/client_model/client_model.dart';

class clientDateText extends StatelessWidget {
  const clientDateText({
    super.key,
    required this.clientDetailsClick,
  });

  final ClientModel clientDetailsClick;

  @override
  Widget build(BuildContext context) {
    String formattedDate = '';

    try {
      // Assuming date is stored in yyyy-MM-dd format (e.g. 2025-04-06)
      DateTime parsedDate = DateTime.parse(clientDetailsClick.date);
      formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);
    } catch (e) {
      // If parsing fails, use original string as fallback
      formattedDate = clientDetailsClick.date;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date : ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: grey,
            ),
          ),
          SizedBox(width: 45),
          Expanded(
            child: Text(
              formattedDate,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 61, 147, 147),
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
