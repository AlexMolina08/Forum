/*
* Pantalla para registrarse en Forum
* */
import 'package:flutter/material.dart';
import 'package:forum/constants.dart';
import 'package:forum/screens/chat_screen.dart';
import 'package:forum/widgets/auth_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart'; // Circulo de progreso (cargando)

class RegisterScreen extends StatefulWidget {
  static const String routeID = '/register'; //Ruta de esta página en la app

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  bool _isInAsyncCall = false; // Flag para saber cuando mostrar animacion de cargando
  String _email, _password;
  final FirebaseAuth _auth = FirebaseAuth.instance; // Instancia FirebaseAuth

  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: _isInAsyncCall,
        child: Padding(
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
                decoration:
                    kTextFieldDecoration.copyWith(hintText: kEmailHintText),
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
                decoration:
                    kTextFieldDecoration.copyWith(hintText: kPasswordHintText),
              ),
              SizedBox(
                height: 24.0,
              ),

              //BOTÓN REGISTRARSE
              AuthButton(
                text: 'Registrarse',
                color: kRegisterButtonColor,
                onPressed: () async {
                  setState(()=>_isInAsyncCall = true); // ponemos spinner
                  // Creamos un nuevo usuario
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: _email, password: _password);

                    if (newUser != null) // si FirebaseAuth no devuelve null , vamos a la pantalla de chat
                      Navigator.pushNamed(context, ChatScreen.routeID);

                    setState(()=>_isInAsyncCall = false);

                  } on FirebaseAuthException catch (e) {
                    setState(()=>_isInAsyncCall = false);
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
