/*
* Pantalla para registrarse en Forum
* */

import  'package:flutter/material.dart';
import 'package:forum/constants.dart';
import 'package:forum/screens/chat_screen.dart';
import 'package:forum/widgets/auth_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeID = '/register'; //Ruta de esta página en la app

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  String _email ,
         _password ;

  final FirebaseAuth _auth = FirebaseAuth.instance; // Instancia FirebaseAuth


  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // LOGO
            Hero(
              tag: kLogoAnimationTag,
              child: Container(
                child: Image.asset('images/logo.png'),
                height: 150.0,
              ),
            ),

            SizedBox(
              height: 40.0,
            ),

            // TEXTFIELD INTRODUCIR CORREO
            TextField(
              keyboardType: TextInputType.emailAddress,
              focusNode: focusNode,
              textAlign: TextAlign.center,
              onChanged: (value) {
                _email = value;
              },
              decoration: kTextFieldDecoration.copyWith(hintText: kEmailHintText),
            ),
            SizedBox(
              height: 20.0,
            ),
            // TEXTFIELD INTRODUCIR CONTRASEÑA
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                _password = value;
              },
              decoration: kTextFieldDecoration.copyWith(hintText: kPasswordHintText),
            ),
            SizedBox(
              height: 24.0,
            ),

            //BOTÓN REGISTRARSE
            AuthButton(
              text: 'Registrarse',
              color: kRegisterButtonColor,
              onPressed: () async{
                // Creamos un nuevo usuario
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
                  if(newUser != null) // si FirebaseAuth no devuelve null , vamos a la pantalla de chat
                    Navigator.pushNamed(context, ChatScreen.routeID);
                } on FirebaseAuthException catch (e) {
                  print(e);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
