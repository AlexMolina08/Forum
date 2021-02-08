/*
* Pantalla para registrarse en Forum
* */
import 'package:flutter/material.dart';
import 'package:forum/constants.dart';
import 'package:forum/screens/chat_screen.dart';
import 'package:forum/widgets/auth_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart'; // Circulo de progreso (cargando)
import 'package:forum/widgets/custom_textfield.dart';




class RegisterScreen extends StatefulWidget {
  static const String routeID = '/register'; //Ruta de esta página en la app

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final FirebaseAuth _auth = FirebaseAuth.instance; // Instancia FirebaseAuth
  final GlobalKey<FormState> _passwordForm = GlobalKey<FormState>(); // formulario para textfield contraseña
  final GlobalKey<FormState> _emailForm = GlobalKey<FormState>();// formulario para textfield email

  bool _isInAsyncCall = false; // Flag para saber cuando mostrar animacion de cargando
  String _email, _password;
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
              // LOGO ( con hero animation)
              Flexible( // se intenta que el tamaño sea 150 , si no se puede lo establece a menos
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

              // TEXTFIELD INTRODUCIR CORREO
              CustomTextField(
                form: _passwordForm,
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
                form: _emailForm,
                obscureText: true,
                onChanged: (value) {
                  _password = value;
                },
                hintText: kPasswordHintText,

                // validator es la funcion que valida si el formulario es correcto
                // en este caso si se ha introducido una contraseña superior a 6 caracteres
                validator: (val){
                  return val.length < 6 ? 'La contraseña tiene que ser mayor a 6 dígitos' : null;
                },
              ),

              SizedBox(
                height: 24.0,
              ),

              //BOTÓN REGISTRARSE
              Hero(
                tag: 'register',
                child: AuthButton(
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

                    } catch (e) {
                      // si no se ha podido registrar el usuario , validamos los formularios de los textfield para mostrar aviso

                      _passwordForm.currentState.validate(); _emailForm.currentState.validate();
                      setState(()=>_isInAsyncCall = false);
                      print(e);
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
