import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:phototickapp/db/client_model/client_model.dart';

ValueNotifier<List<ClientModel>> clientListNotifier = ValueNotifier([]);
ValueNotifier<List<ClientModel>> _equipmentsList = ValueNotifier([]);

Future<void> addClient(ClientModel Clients) async {
  clientListNotifier.value.add(Clients);
  final Box = await Hive.openBox<ClientModel>('Client_Box');
  await Box.put(Clients.id, Clients);
  getAllClients();
}

Future getAllClients() async {
  clientListNotifier.value.clear();
  _equipmentsList.value.clear();
  final Box = await Hive.openBox<ClientModel>('Client_Box');
  clientListNotifier.value.addAll(Box.values);
  clientListNotifier.notifyListeners();
}

Future<void> updatedClients(ClientModel updatedClients) async {
  final Box = await Hive.openBox<ClientModel>('Client_Box');
  if (Box.containsKey(updatedClients.id)) {
    await Box.put(updatedClients.id, updatedClients);
    getAllClients();
  }
}

Future<void> deleteClient(String id) async {
  final Box = await Hive.openBox<ClientModel>('Client_Box');
  await Box.delete(id);
  getAllClients();
}

String randomId2() {
  String randomId2 = DateTime.now().microsecondsSinceEpoch.toString();
  return randomId2;
}
