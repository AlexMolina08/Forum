import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:forum/constants.dart';

// A widget that displays the picture taken by the user.
class PictureScreen extends StatelessWidget {

  static const routeID = '/picture';
  final String imagePath;
  const PictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('envia una foto' , style: kPhotoAppBarTextStyle,),
        leading: Container(
          padding: EdgeInsets.all(5.0),
          child: Image.asset('images/logo.png'),
        ),
        actions: [
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Icon(
              Icons.clear,
              color: Colors.white,
            ),
          )
        ],
      ),
        // The image is stored as a file on the device. Use the `Image.file`
        // constructor with the given path to display the image.
        body: Column(
          children: [
            Expanded(
              child: Image.file(
                File(imagePath),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
