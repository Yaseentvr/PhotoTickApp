import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/bottomNavigation/images%20screen/image_Details.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/bottomNavigation/images%20screen/imagesAdd.dart';
import 'package:phototickapp/db/image_Screen_db/imageScreen_Db.dart';
import 'package:phototickapp/db/image_Screen_model/imageScreen%20_model.dart';
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
    // TODO: implement initState
    super.initState();
    _loadImages();
  }

  @override
  Widget build(BuildContext context) {
    Screensize();
    return Scaffold(
                backgroundColor: Color(0xFFEFFBFB),

        appBar: AppBar(
                 backgroundColor: Color(0xFFEFFBFB),

          centerTitle: true,
          title: Text(
            'Favourite images',
            style: TextStyle(
                color: Color(0xFF57CFCE),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF57CFCE),
          foregroundColor: Colors.white,
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
          child: Icon(Icons.add),
        ),
        body: ValueListenableBuilder(
            valueListenable: imageNotifier,
            builder: (context, List<imagescreen_Model> imageList, child) {
              if (imageList.isEmpty) {
                return Center(
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
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
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
                        shadowColor: Colors.black,
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
                                      deleteImage(imageItem.imageId);
                                    },
                                    icon: Icon(Icons.delete,color: Colors.red,)),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }));
  }

  Future<void> _loadImages() async {
    final imageBox = await Hive.openBox<imagescreen_Model>(imageName);
    print('data ${imageBox.values}');
    setState(() {
      imageNotifier.value = imageBox.values.toList();
      imageNotifier.notifyListeners();
    });
  }
}
