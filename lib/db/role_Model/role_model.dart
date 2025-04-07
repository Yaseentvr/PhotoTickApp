import 'package:hive_flutter/adapters.dart';

part 'role_model.g.dart';

@HiveType(typeId: 4)
class RoleModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  late String role;

  RoleModel(this.id, {required this.role});
}
