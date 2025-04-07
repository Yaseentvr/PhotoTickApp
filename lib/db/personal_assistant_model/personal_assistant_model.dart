import 'package:hive_flutter/adapters.dart';

part 'personal_assistant_model.g.dart';

@HiveType(typeId: 7)
class PersonalAssistantModel {
  @HiveField(0)
  final String assId;
  @HiveField(1)
  final String assistantName;
  @HiveField(2)
  final String assistantPhone;
  @HiveField(3)
  final String clientId;

  PersonalAssistantModel({
    required this.assId,
    required this.assistantPhone,
    required this.assistantName,
    required this.clientId,
  });
}
