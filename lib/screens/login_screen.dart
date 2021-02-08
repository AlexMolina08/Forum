/*
* Pantalla de inicion de sesión de Forum
* */
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:forum/constants.dart';
import 'package:forum/screens/chat_screen.dart';
import 'package:forum/widgets/auth_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forum/widgets/custom_textfield.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart'; // Circulo de progreso (cargando)





class LoginScreen extends StatefulWidget {
  static const String routeID = '/login'; //Ruta de esta página en la app

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _passwordForm = GlobalKey<FormState>(); // formulario para textfield contraseña
  final GlobalKey<FormState> _emailForm = GlobalKey<FormState>();// formulario para textfield email

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
              Flexible(
                child: Hero(
                  tag: kLogoAnimationTag,
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 200.0,
                  ),
                ),
              ),

              SizedBox(
                height: 40.0,
              ),


              CustomTextField(
                  form: _emailForm,
                  hintText: kEmailHintText,
                  onChanged: (value){
                    _email = value;
                  },
                  validator : (val){
                    return  !val.contains('@') ? 'Introduce correo válido' : null ;
                  }
              ),
              SizedBox(
                height: 20.0,
              ),
              // TEXTFIELD INTRODUCIR CONTRASEÑA
              CustomTextField(
                form: _passwordForm,
                hintText: kPasswordHintText,
                obscureText: true,
                onChanged: (value) {
                  _password = value;
                },
                validator: (val) {
                  return val.length < 6 ? 'La contraseña tiene que ser mayor a 6 dígitos' : null;
                },


              ),

              SizedBox(
                height: 24.0,
              ),

              // BOTÓN PARA INICIAR SESIÓN
              Hero(
                tag: kLoginButtonTag,
                child: AuthButton(
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
                      // si no se ha podido registrar el usuario , validamos los formularios de los textfield para mostrar aviso
                      _emailForm.currentState.validate(); _passwordForm.currentState.validate();

                      print(e);
                      setState(() {_isInAsyncCall = false;});
                    }

                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
