/*
* Pantalla de inicion de sesión de Forum
* */
import 'package:flutter/material.dart';
import 'package:forum/constants.dart';
import 'package:forum/screens/chat_screen.dart';
import 'package:forum/widgets/auth_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart'; // Circulo de progreso (cargando)

class LoginScreen extends StatefulWidget {
  static const String routeID = '/login'; //Ruta de esta página en la app

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _isInAsyncCall = false; // Flag para saber cuando mostrar animacion de cargando

  FirebaseAuth _auth = FirebaseAuth.instance; // instancia de firebaseauth
  String _email ,
         _password;



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
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    _email = value;
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
                  _password = value;
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
                  setState(() => _isInAsyncCall = true);//Activamos flag para activar spinner
                  try{
                    final loggedUser = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
                    print(loggedUser.user);
                    if(loggedUser != null){ // Si el usuario existe
                      Navigator.pushNamed(context, ChatScreen.routeID);
                    }

                    setState(() => _isInAsyncCall = false);
                  }catch(e){
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
