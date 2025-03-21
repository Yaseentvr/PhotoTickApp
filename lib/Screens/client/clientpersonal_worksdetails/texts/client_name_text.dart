import 'package:flutter/material.dart';
import 'package:phototickapp/db/client_model/client_model.dart';

class clientNameText extends StatelessWidget {
  const clientNameText({
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
              'Name : ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(width: 8),
          Flexible(
            child: Text(
              '${clientDetailsClick.name}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 61, 147, 147),
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
