import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:forum/constants.dart';

class LoadingScreen extends StatefulWidget {
  static const String routeID = '/loading';

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {




  @override
  void initState() {
    initializeFirebase();
    super.initState();

  }

  void initializeFirebase() async {

    await Firebase.initializeApp();


    Navigator.pushNamed(context,'/');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(50.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/logo.png'),
            ],
          ),
        ),
      ),
    );
  }
}
