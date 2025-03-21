import 'package:hive_flutter/adapters.dart';
part 'login_model.g.dart';

@HiveType(typeId: 2)
class Loginmodel {
  @HiveField(0)
  String id;
  @HiveField(1)
  final String loginName;
  @HiveField(2)
  final String loginPhone;

  Loginmodel(
      {
        required this.loginName, required this.loginPhone, required this.id});
}
