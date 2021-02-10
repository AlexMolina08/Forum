import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';


//**************** STRINGS ***************

const String kEmailHintText = 'Introduce Correo';
const String kPasswordHintText = 'Introduce Contraseña';


const String kForumVersion = '1.0';



//*************** TEXTSTYLES ******************


const TextStyle kLogoTextStyle = TextStyle(
  fontSize: 50.0 ,
  fontWeight: FontWeight.w300,
  color: Color(0xff424242)
);

const TextStyle kLoadingTextStyle = TextStyle(
    fontSize: 20.0 ,
    fontWeight: FontWeight.w300,
    color: Color(0xff424242)
);

const TextStyle kButtonTextStyle = TextStyle(
  fontSize: 25.0 ,
  letterSpacing: 1.5,
  fontWeight: FontWeight.w500,
  color: Colors.black
);

const TextStyle kMessageTextStyle = TextStyle(
  fontSize: 15.0,
  color: Colors.white
);

const TextStyle kOthersTextStyle = TextStyle(
  fontSize: 15.0,
  color: Colors.black
);

const TextStyle kSenderTextStyle = TextStyle(
  fontSize: 10.0,
  color: Colors.blueGrey
);

const TextStyle kHintTextStyle = TextStyle(
  fontSize: 20.0,
  color: Color(0xff757575),
);


const kPhotoAppBarTextStyle = TextStyle(
    fontSize: 20.0 ,
    fontWeight: FontWeight.w300,
    color: Colors.white,
);


// ******************* DECORATION ************************

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

final kInnerDecoration = BoxDecoration(
  color: Colors.white,
  border: Border.all(color: Colors.white),
  borderRadius: BorderRadius.circular(32),
);

final kGradientBoxDecoration = BoxDecoration(
  gradient: LinearGradient(colors: [Colors.white, Colors.black]),
  border: Border.all(
    color: Colors.white,
  ),
  borderRadius: BorderRadius.circular(32),
);


const InputDecoration kTextFieldDecoration = InputDecoration(
  floatingLabelBehavior: FloatingLabelBehavior.never,
  hintStyle: kHintTextStyle,
  contentPadding:
  EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),

  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(32.0),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: NeumorphicColors.disabled , width: 0.0),
    borderRadius: BorderRadius.all(
      Radius.circular(32.0),
    ),
  ),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: NeumorphicColors.accent),
      borderRadius: BorderRadius.all(
        Radius.circular(32.0),
      )),
);

// ***************** ANIMATION TAGS *****************

String kLogoAnimationTag = 'logo';
String kLoginButtonTag = 'login';
String kRegisterButtonTag = 'register';

// ***************** colors *********************

const Color kRegisterButtonColor = Color(0xff0d47a1);
const Color kLoginButtonColor = Color(0xff1e88e5);
const Color kChatTextFieldColor = Color(0xffe0e0e0);
const Color kFieldFocusColor = Color(0xfffbc02d);
const Color kFieldEnabledColor = Color(0xff0288d1);
const Color kLoadingAnimationColor = Color(0xff424242);
const Color kOthersMessageColor = Color(0xffe0e0e0);
const Color kUserMessageColor = Color(0xff0288d1);
