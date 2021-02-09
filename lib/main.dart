import 'package:flutter/material.dart';
import 'package:forum/screens/chat_screen.dart';
import 'package:forum/screens/loading_screen.dart';
import 'package:forum/screens/login_screen.dart';
import 'package:forum/screens/register_screen.dart';
import 'package:forum/screens/welcome_screen.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:camera/camera.dart';
import 'package:forum/screens/camera_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras =
      await availableCameras(); // obtengo lista de las camaras disponibles
  final firstCamera = cameras.first; // escogemos la primera de la lista

  runApp(Forum(camera: firstCamera));
}

class Forum extends StatelessWidget {

  final CameraDescription camera ; // Camara que se va a usar

  Forum({@required this.camera});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: NeumorphicTheme.baseColor(context),
      ),

      // Rutas de la app
      // Accedo al nombre de la ruta (key del map de routes) accediendo al atributo estático routeID de cada clase
      routes: {
        WelcomeScreen.routeID: (context) => WelcomeScreen(),
        RegisterScreen.routeID: (context) => RegisterScreen(),
        LoginScreen.routeID: (context) => LoginScreen(),
        ChatScreen.routeID: (context) => ChatScreen(),
        LoadingScreen.routeID: (context) => LoadingScreen(),
        CameraScreen.routeID: (context) => CameraScreen(camera: camera,),
      },

      initialRoute: LoadingScreen.routeID,
    );
  }
}

