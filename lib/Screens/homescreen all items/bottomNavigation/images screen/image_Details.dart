import 'dart:io';

import 'package:flutter/material.dart';
import 'package:phototickapp/db/image_Screen_model/imageScreen%20_model.dart';

class ImageDetails extends StatelessWidget {
  final imagescreen_Model ImageDetailShow;
  const ImageDetails({super.key, required this.ImageDetailShow});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F4F3),
      appBar: AppBar(backgroundColor: Color(0xFFF2F4F3)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Card(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                    child: Image.file(
                      File(ImageDetailShow.imagePath),
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Date: ${ImageDetailShow.date1}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Place :${ImageDetailShow.place}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '${ImageDetailShow.description}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
