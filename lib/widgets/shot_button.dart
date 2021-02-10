import 'package:flutter/material.dart';
import 'package:forum/constants.dart';

class ShotButton extends StatefulWidget {

  final Function onPressed;

  ShotButton({this.onPressed});

  @override
  _ShotButtonState createState() => _ShotButtonState();
}

class _ShotButtonState extends State<ShotButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.blue, Colors.red]),
        border: Border.all(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(32),
      ),
      height: 66.0,
      width: 66.0,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          child: FlatButton(
            child: Icon(Icons.camera_rounded),
            onPressed: () async {},
          ),
          decoration: kInnerDecoration,
        ),
      ),
    );
  }
}
