import 'package:flutter/material.dart';
import 'package:forum/screens/login_screen.dart';
import 'package:forum/screens/register_screen.dart';
import 'package:forum/screens/welcome_screen.dart';

void main() => runApp( Forum());

class Forum extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Rutas de la app
      // Accedo al nombre de la ruta (key del map de routes) accediendo al atributo estático routeID de cada clase
      routes: {
        WelcomeScreen.routeID : (context) => WelcomeScreen(),
        RegisterScreen.routeID : (context) => RegisterScreen(),
        LoginScreen.routeID : (context) => LoginScreen(),
      },

      initialRoute: WelcomeScreen.routeID,
    );
  }
}
