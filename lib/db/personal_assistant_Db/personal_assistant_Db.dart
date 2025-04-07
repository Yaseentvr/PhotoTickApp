import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:phototickapp/db/personal_assistant_model/personal_assistant_model.dart';

String assBoxName = 'assBox';

ValueNotifier<List<PersonalAssistantModel>> personalAssistantListNotifier =
    ValueNotifier([]);

Future<void> addPersonalAssistant(PersonalAssistantModel assist) async {
  final box = await Hive.openBox<PersonalAssistantModel>(assBoxName);
  await box.put(assist.assId, assist);
  personalAssistantListNotifier.value.add(assist);
  personalAssistantListNotifier.notifyListeners();
}

Future<void> getAllPersonalAss() async {
  final box = await Hive.openBox<PersonalAssistantModel>(assBoxName);
  personalAssistantListNotifier.value = box.values.toList();
  personalAssistantListNotifier.notifyListeners();
}
