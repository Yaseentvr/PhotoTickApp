import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:phototickapp/db/role_Model/role_model.dart';

final ValueNotifier<List<RoleModel>> roleListNotifier = ValueNotifier([]);

Future<void> addRole(RoleModel role) async {
  roleListNotifier.value.add(role);
  final Boxrole = await Hive.openBox<RoleModel>('roleBox');
  await Boxrole.put(role.id, role);
  getAllRole();
}

Future<void> getAllRole() async {
  roleListNotifier.value.clear();
  final Boxrole = await Hive.openBox<RoleModel>('roleBox');
  roleListNotifier.value.addAll(Boxrole.values);
  roleListNotifier.notifyListeners();
}

Future<void> deleteRole(String id) async {
  final Boxrole = await Hive.openBox<RoleModel>('roleBox');
  await Boxrole.delete(id);
  getAllRole();
}

randomId1() {
  String randomId1 = DateTime.now().microsecondsSinceEpoch.toString();
  return randomId1;
}
