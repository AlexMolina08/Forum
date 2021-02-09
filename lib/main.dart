import 'package:flutter/material.dart';
import 'package:forum/screens/chat_screen.dart';
import 'package:forum/screens/loading_screen.dart';
import 'package:forum/screens/login_screen.dart';
import 'package:forum/screens/register_screen.dart';
import 'package:forum/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(Forum());
}

class Forum extends StatelessWidget {

  bool isFirebaseReady = false;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      theme: ThemeData(
        scaffoldBackgroundColor: NeumorphicTheme.baseColor(context),
      ),

      // Rutas de la app
      // Accedo al nombre de la ruta (key del map de routes) accediendo al atributo estático routeID de cada clase
      routes: {
        WelcomeScreen.routeID : (context) => WelcomeScreen(),
        RegisterScreen.routeID : (context) => RegisterScreen(),
        LoginScreen.routeID : (context) => LoginScreen(),
        ChatScreen.routeID : (context) =>  ChatScreen(),
        LoadingScreen.routeID : (context) => LoadingScreen(),
      },

      initialRoute: LoadingScreen.routeID,

    );
  }
}
