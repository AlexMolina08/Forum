/*
* Pantalla para registrarse en Forum
* */

import  'package:flutter/material.dart';
import 'package:forum/constants.dart';
import 'package:forum/widgets/auth_button.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeID = '/register'; //Ruta de esta página en la app

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
              onChanged: (value) {},
              decoration: kTextFieldDecoration.copyWith(hintText: 'Introduce Correo'),
            ),
            SizedBox(
              height: 20.0,
            ),
            // TEXTFIELD INTRODUCIR CONTRASEÑA
            TextField(
              onChanged: (value) {},
              decoration: kTextFieldDecoration.copyWith(hintText: 'Introduce Contraseña'),
            ),
            SizedBox(
              height: 24.0,
            ),

            //BOTÓN REGISTRARSE
            AuthButton(
              text: 'Registrarse',
              color: kRegisterButtonColor,
              onPressed: () {
                // TODO IMPLEMENTAR REGISTER
              },
            ),
          ],
        ),
      ),
    );
  }
}
