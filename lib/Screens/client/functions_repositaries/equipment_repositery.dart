// equipment_repository.dart

import 'package:hive/hive.dart';
import 'package:phototickapp/db/client_model/client_model.dart';

class EquipmentRepository {
  Future<ClientModel?> getClient(String clientId) async {
    final box = await Hive.openBox<ClientModel>('Client_Box');
    return box.get(clientId);
  }

  Future<void> saveEquipments(String clientId, List<String> equipments) async {
    final box = await Hive.openBox<ClientModel>('Client_Box');
    ClientModel? client = await getClient(clientId);

    if (client != null) {
      client.personalEquipments = List.from(equipments); // Update personalEquipments
      await box.put(clientId, client);
      print('Equipments saved: ${client.personalEquipments}');
    } else {
      print('Client not found');
    }
  }

  Future<void> deleteEquipment(String clientId, String equipment) async {
    final box = await Hive.openBox<ClientModel>('Client_Box');
    ClientModel? client = await getClient(clientId);

    if (client != null) {
      client.personalEquipments?.remove(equipment);
      await box.put(clientId, client);
      print('Equipment deleted: $equipment');
    } else {
      print('Client not found');
    }
  }
}