import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forum/constants.dart';
import 'package:forum/widgets/chat_textfield.dart';

class ChatScreen extends StatefulWidget {
  static const String routeID = '/chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  User _loggedUser;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCurrentUser();

  }

  /*
  * Función que determina si hay un usuario logeado
  * Obtiene el currentuser , si no es null , lo asigna a _loggeduser
  * */

  void getCurrentUser() {
    try{
      final User user =  _auth.currentUser;
      if (user != null) { // Si hay un usuario , creamos un nuevo firebaseuser
        _loggedUser = user;
        print('CHAT SCREEN: usuario logeado: ${_loggedUser.email}');
      }
    } catch (e){
      print(e);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        leading: null,
        actions: [
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async{
                await _auth.signOut();
                Navigator.pop(context);
              },),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ChatTextField(),
          ],
        ),
      ),
    );
  }
}
