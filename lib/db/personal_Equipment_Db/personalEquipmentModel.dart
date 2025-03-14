

import 'package:hive_flutter/adapters.dart';
part 'personalEquipmentModel.g.dart';
@HiveType(typeId: 9)
class Personalequipmentmodel {
  @HiveField(0)
  final String equipment;

  Personalequipmentmodel({required this.equipment});
}