import 'package:hive/hive.dart';
import 'package:phototickapp/db/role_Model/role_model.dart';

part 'db_model.g.dart';

@HiveType(typeId: 1)
class AssistantModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String Phone;
  @HiveField(3)
  final String Place;
  @HiveField(4)
  final List<RoleModel> selectedroles;
  @HiveField(5)
  final String equipment;

  AssistantModel({
    required this.name,
    required this.Phone,
    required this.Place,
    required this.id,
    required this.selectedroles,
    required this.equipment,
  });
}
