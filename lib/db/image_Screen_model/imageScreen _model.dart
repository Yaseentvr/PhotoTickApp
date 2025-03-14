
import 'package:hive_flutter/adapters.dart';

part 'imageScreen _model.g.dart';

@HiveType(typeId: 10)
class imagescreen_Model {
  @HiveField(0)
  final String imageId;
  @HiveField(1)
  final String imagePath;
  @HiveField(2)
  final String place;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final String date1;



  imagescreen_Model({
    required this.imagePath,
    required this.imageId,
    required this.place,
    required this.description,
    required this.date1,
  });
}