import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:phototickapp/db/assistant_model/db_model.dart';

final ValueNotifier<List<AssistantModel>> assistantListNotifier =
ValueNotifier([]);

Future<void> addAssistant(AssistantModel assistant) async {
  assistantListNotifier.value.add(assistant);
  final box = await Hive.openBox<AssistantModel>('assistant_db');
  await box.put(assistant.id, assistant);
  gettAllAssistant();
}


Future<void> deleteAssistant(String id) async {
  final Box = await Hive.openBox<AssistantModel>('assistant_db');
  await Box.delete(id);
  gettAllAssistant();
}

Future<void> updateAssistant(AssistantModel updatedAssistant) async {
  final box = await Hive.openBox<AssistantModel>('assistant_db');
  if (box.containsKey(updatedAssistant.id)) {
    await box.put(updatedAssistant.id, updatedAssistant);
    await gettAllAssistant();
  }
}

randomId() {
  String randomId = DateTime.now().microsecondsSinceEpoch.toString();
  return randomId;
}


Future<void> gettAllAssistant() async {
  assistantListNotifier.value.clear();
  final Box = await Hive.openBox<AssistantModel>('assistant_db');
  assistantListNotifier.value.addAll(Box.values);
  assistantListNotifier.notifyListeners();
}
