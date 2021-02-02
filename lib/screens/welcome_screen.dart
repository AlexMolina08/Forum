import 'package:flutter/material.dart';
import 'package:forum/constants.dart';
import 'package:forum/screens/login_screen.dart';
import 'package:forum/screens/register_screen.dart';
import 'package:forum/widgets/auth_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeID = '/'; //Ruta de esta página en la app

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

//Esta clase actua como un ticker
// (usamos SingleTiker provider porque solo vamos a manejar una animacion)

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {

  AnimationController controller; // controller de la animacion
  Animation animation; // para curvedAnimation

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    // Creamos un ColorTween (va de un color a otro)
    // Llamamos al metodo animate y le pasamos nuestro animationController
    // el metodo animate devuelve una animation
    animation = CurvedAnimation(
      curve: Curves.elasticOut,
      parent: controller
    );

    // Iniciamos la animacion
    controller.forward();
    // EL listener que se añade al controller se llama cada vez que el value del controller
    // cambia
    controller.addListener(() {
      setState(() {});
    });
  }

  // Se llama cuando el widget se elimina
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // logo y nombre
            Row(
              children: [
                // LOGO (ANIMADO)
                Hero(
                  tag: kLogoAnimationTag,
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: animation.value*100,
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                /*Text(
                  'Forum',

                  style: kLogoTextStyle,
                ),*/

                TypewriterAnimatedTextKit(
                  speed: Duration(milliseconds: 200),
                  //boxBackgroundColor: Colors.transparent,
                  text: ['Forum'],
                  textStyle: kLogoTextStyle,
                ),

              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            //Botón de iniciar sesión
            AuthButton(
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.routeID);
              },
              text: 'Inicia Sesión',
              color: kLoginButtonColor,
            ),
            SizedBox(
              height: 30.0,
            ),
            //Botón de registrarse
            AuthButton(
              onPressed: () {
                Navigator.pushNamed(context, RegisterScreen.routeID);
              },
              text: 'Regístrate',
              color: kRegisterButtonColor,
            ),
          ],
        ),
      ),
    );
  }
}
