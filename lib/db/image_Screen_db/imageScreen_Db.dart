import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:phototickapp/db/image_Screen_model/imageScreen%20_model.dart';

final String imageName = 'image';

ValueNotifier<List<imagescreen_Model>> imageNotifier = ValueNotifier([]);

Future<void> addImage(imagescreen_Model imageId1) async {
  final imageBox = await Hive.openBox<imagescreen_Model>(imageName);
  await imageBox.put(imageId1.imageId, imageId1);
  imageNotifier.value.add(imageId1);
  imageNotifier.notifyListeners();
}

Future<void> deleteImage(String imageId) async {
  var imageBox = await Hive.openBox<imagescreen_Model>(imageName);
  await imageBox.delete(imageId);
  imageNotifier.value.removeWhere((image) => image.imageId == imageId);
  print('deleted${imageId}');
  imageNotifier.notifyListeners();
}
