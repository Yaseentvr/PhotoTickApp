import 'package:flutter/material.dart';
import 'package:phototickapp/db/client_model/client_model.dart';

class clientLocationText extends StatelessWidget {
  const clientLocationText({
    super.key,
    required this.clientDetailsClick,
  });

  final ClientModel clientDetailsClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              'Location :',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              '${clientDetailsClick.location}',
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
