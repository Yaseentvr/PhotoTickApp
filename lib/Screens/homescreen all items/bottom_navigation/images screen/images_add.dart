import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phototickapp/db/image_screen_db/image_screen_Db.dart';
import 'package:phototickapp/db/image_screen_model/image_screen%20_model.dart';

class Imagesadd extends StatefulWidget {
  const Imagesadd({super.key});

  @override
  State<Imagesadd> createState() => _ImagesaddState();
}

class _ImagesaddState extends State<Imagesadd> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  DateTime? selectedDate;

  TextEditingController placeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFEFFBFB),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Card(
                      child: Container(
                    width: 150,
                    height: 150,
                    color: Color(0xFF57CFCE),
                    child: _image != null
                        ? Image.file(
                            _image!,
                            fit: BoxFit.cover,
                          )
                        : IconButton(
                            onPressed: () {
                              _imagePickerGallery();
                            },
                            icon: Icon(
                              Icons.photo_library_rounded,
                              size: 45,
                              color: Colors.white,
                            )),
                  )),
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextField(
                    controller: dateController,
                    decoration: InputDecoration(
                        labelText: 'Date',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    readOnly: true,
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime(2024),
                        lastDate: DateTime(2115),
                      );
                      if (picked != null) {
                        setState(() {
                          selectedDate = picked;
                          dateController.text =
                              '${picked.day}-${picked.month}-${picked.year}';
                        });
                      }
                    },
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextField(
                    controller: placeController,
                    decoration: InputDecoration(
                        labelText: 'Place',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                SizedBox(height: 35),
                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30),
                  child: ElevatedButton(
                      onPressed: () {
                        _saveData();
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                          backgroundColor: Color(0xFF57CFCE),
                        ),
                      child: Text('Save',style: TextStyle(color: Colors.white,fontSize: 20),)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _imagePickerGallery() async {
    // Removed the unused local variable 'picker'
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future<void> _saveData() async {
    if (_image == null ||
        placeController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        selectedDate == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please fill all fields')));
      return;
    }
    final String imageId1 = DateTime.now().toString();
    final String formatedDate = dateController.text;
    final String place = placeController.text;
    final String description = descriptionController.text;
    final imagescreen_Model imageData = imagescreen_Model(
      imagePath: _image!.path,
      imageId: imageId1,
      place: place,
      description: description,
      date1: formatedDate,
    );
    final imageBox = await Hive.openBox<imagescreen_Model>(imageName);
    await imageBox.put(imageData.imageId, imageData);

    print('image saved ${imageData.imagePath}');
    print('Box length ${imageBox.length}');

    imageNotifier.value.add(imageData);
    imageNotifier.notifyListeners();
    // await addImage(imageData);
    Navigator.pop(context);
  }

  void _checkData() async {
    final imageBox = await Hive.openBox<imagescreen_Model>(imageName);
    imageBox.values.forEach((image) {
      print('saved image ${image.imagePath}');
    });
  }
}
