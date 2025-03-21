import 'package:flutter/material.dart';
import 'package:phototickapp/db/assistant_model/db_model.dart';

class no_roles_given_text_check extends StatelessWidget {
  const no_roles_given_text_check({
    super.key,
    required this.assistant,
  });

  final AssistantModel assistant;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          assistant.selectedroles.isNotEmpty
              ? assistant.selectedroles.map((role) => role.role).join(', ')
              : 'No roles given',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
