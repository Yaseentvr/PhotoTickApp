import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/bottom_navigation/images%20screen/image_details.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/bottom_navigation/images%20screen/images_add.dart';
import 'package:phototickapp/colors/colors.dart';
import 'package:phototickapp/db/image_screen_db/image_screen_Db.dart';
import 'package:phototickapp/db/image_screen_model/image_screen%20_model.dart';
import 'package:phototickapp/screen_Sizes/screenSize.dart';

class Imagesscreen extends StatefulWidget {
  final imagescreen_Model images;
  const Imagesscreen({super.key, required this.images});

  @override
  State<Imagesscreen> createState() => _ImagesscreenState();
}

class _ImagesscreenState extends State<Imagesscreen> {
  List<String> imagePaths = [];

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  @override
  Widget build(BuildContext context) {
    Screensize();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text(
          'Favourite images',
          style: TextStyle(
              color: appBarColor,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appBarColor,
        foregroundColor: white,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return Imagesadd();
            },
          ).then((value) {
            _loadImages();
          });
        },
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
          valueListenable: imageNotifier,
          builder: (context, List<imagescreen_Model> imageList, child) {
            if (imageList.isEmpty) {
              return const Center(
                child: Text('No images added'),
              );
            }
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemCount: imageList.length,
                itemBuilder: (context, index) {
                  final imageItem = imageList[index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return ImageDetails(
                          ImageDetailShow: imagescreen_Model(
                              imagePath: imageItem.imagePath,
                              imageId: imageItem.imageId,
                              place: imageItem.place,
                              date1: imageItem.date1,
                              description: imageItem.description),
                        );
                      }));
                    },
                    child: Card(
                      elevation: 5,
                      shadowColor: black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10),
                              ),
                              child: Image.file(
                                File(imageItem.imagePath),
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    _confirmDelete(imageItem.imageId);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: deleteColor,
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }

  Future<void> _loadImages() async {
    final imageBox = await Hive.openBox<imagescreen_Model>(imageName);
    setState(() {
      imageNotifier.value = imageBox.values.toList();
      imageNotifier.notifyListeners();
    });
  }

  void _confirmDelete(String imageId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this image?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                deleteImage(imageId);
                Navigator.of(context).pop(); // Close the dialog
                _loadImages(); // Reload images after deletion
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}