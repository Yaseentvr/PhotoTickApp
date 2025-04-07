import 'package:hive_flutter/adapters.dart';

part 'client_model.g.dart';

@HiveType(typeId: 3)
class ClientModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String date;
  @HiveField(2)
  String time;
  @HiveField(3)
  String name;
  @HiveField(4)
  String location;
  @HiveField(5)
  String event;
  @HiveField(6)
  String phone;
  @HiveField(7)
  String budget;

  @HiveField(8)
  List<dynamic>? personalAssistants = [];

  @HiveField(9)
  List<String>? personalEquipments = [];

  @HiveField(10)
  List<double>? personalExpenses = [];
  @HiveField(11)
  String driveLink1;

  ClientModel({
    required this.id,
    required this.date,
    required this.time,
    required this.name,
    required this.location,
    required this.event,
    required this.phone,
    required this.budget,
    this.personalAssistants,
    this.personalEquipments,
    required this.driveLink1,
  });
}
