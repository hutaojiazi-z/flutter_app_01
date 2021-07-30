import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zyl_app2/base/view.dart';

class LoveImageView extends StatefulWidget {
  @override
  _LoveImageViewState createState() => _LoveImageViewState();
}

class _LoveImageViewState extends State<LoveImageView> {

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar("图片列表"),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: getImage,
      ),
      body: _image != null ? Center(
        child: Image.file(_image),
      ) : Center(),
    );
  }

}
