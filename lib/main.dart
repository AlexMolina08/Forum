import 'package:flutter/material.dart';
import 'package:forum/screens/chat_screen.dart';
import 'package:forum/screens/login_screen.dart';
import 'package:forum/screens/register_screen.dart';
import 'package:forum/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print(e);
  }
  runApp(Forum());
}

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
        ChatScreen.routeID : (context) =>  ChatScreen()
      },

      initialRoute: WelcomeScreen.routeID,
    );
  }
}
