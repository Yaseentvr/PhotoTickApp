import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:phototickapp/db/login_model/loginModel.dart';

final ValueNotifier<List<Loginmodel>> LoginListNotifier = ValueNotifier([]);

Future<void> addLoginDetail(Loginmodel loginIds) async {
  final userBox = Hive.box<Loginmodel>('loginBox');
  await userBox.put(loginIds.id, loginIds);
}

Future<Loginmodel?> getUser() async {
  final userBox = Hive.box<Loginmodel>('loginBox');
  if (userBox.isNotEmpty) {
    return userBox.values.first;
  }
  return null;
}
