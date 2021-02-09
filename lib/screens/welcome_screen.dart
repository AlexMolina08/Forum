import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
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
    animation = CurvedAnimation(curve: Curves.elasticOut, parent: controller);

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
      //backgroundColor: NeumorphicTheme.baseColor(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // logo y nombre
            Row(
              children: [
                // LOGO (ANIMADO) y versión
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: kLogoAnimationTag,
                      child: Column(
                        children: [
                          Container(
                            child: Image.asset('images/logo.png'),
                            height: animation.value * 100,
                          ),
                        ],
                      ),
                    ),

                    Text('$kForumVersion' , style: TextStyle(fontSize: 12.0),)

                  ],
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
                  text: ['Forum'],
                  textStyle: kLogoTextStyle,
                ),
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            //Botón de iniciar sesión
            Hero(
              tag: kLoginButtonTag,
              child: AuthButton(
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.routeID);
                },
                text: 'Inicia Sesión',
                color: kLoginButtonColor,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            //Botón de registrarse
            Hero(
              tag: 'register',
              child: AuthButton(
                onPressed: () {
                  Navigator.pushNamed(context, RegisterScreen.routeID);
                },
                text: 'Regístrate',
                color: kRegisterButtonColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
