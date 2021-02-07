/*
* Pantalla de inicion de sesión de Forum
* */
import 'package:flutter/material.dart';
import 'package:forum/constants.dart';
import 'package:forum/screens/chat_screen.dart';
import 'package:forum/widgets/auth_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static const String routeID = '/login'; //Ruta de esta página en la app

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  FirebaseAuth _auth = FirebaseAuth.instance; // instancia de firebaseauth

  String email ,
         password;


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
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Introduce Correo')
            ),
            SizedBox(
              height: 20.0,
            ),
            // TEXTFIELD INTRODUCIR CONTRASEÑA
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
              },
              decoration: kTextFieldDecoration.copyWith(hintText:"Introduce Contraseña")
            ),
            SizedBox(
              height: 24.0,
            ),

            // BOTÓN PARA INICIAR SESIÓN
            AuthButton(
              color: kLoginButtonColor,
              text: 'Entrar',
              onPressed: () async{
                try{
                  final loggedUser = await _auth.signInWithEmailAndPassword(email: email, password: password);
                  print(loggedUser.user);
                  if(loggedUser != null){ // Si el usuario existe
                    Navigator.pushNamed(context, ChatScreen.routeID);
                  }

                }catch(e){
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
