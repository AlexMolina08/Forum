import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forum/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forum/widgets/chat_textfield.dart';

class ChatScreen extends StatefulWidget {
  static const String routeID = '/chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance; // instancia de firestore

  User _loggedUser;
  String userMessage; // Mensaje que se envia

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCurrentUser(); // Obtenemos el usuario actual ( lo asignamos si existe a loggedUser)
  }

  /*
  * Función que determina si hay un usuario logeado
  * Obtiene el currentuser , si no es null , lo asigna a _loggeduser
  * */

  void getCurrentUser() {
    try {
      final User user = _auth.currentUser;
      if (user != null) {
        // Si hay un usuario , creamos un nuevo firebaseuser
        _loggedUser = user;
        print('CHAT SCREEN: usuario logeado: ${_loggedUser.email}');
      }
    } catch (e) {
      print(e);
    }
  }

  /*
  void getMessages() async{
    final messages =  await _firestore.collection('messages').get();


    // una vez que obtenemos los documentos de la coleccion , iteramos sobre cada uno de ellos
    for(var message in messages.docs){
      print(message.data());
    }

  }*/


  /*
  * Escucha los mensajes que van añadiendose a firestore
  * */
  void messagesStream() async{

    Stream snapshots = _firestore.collection('messages').snapshots();

    // recorremos cada snapshot (cada cambio que se hace en la base de datos)
    // es decir , que cuando se añada / elimine un mensaje de la coleccion , se llamará a este for
    await for( var snapshot in _firestore.collection('messages').snapshots() ){
      for(var message in snapshot.docs){
        print(message.data());
      }
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
            onPressed: () async {
              messagesStream();
              //await _auth.signOut();
              //Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ChatTextField(
              onChanged: (value){
                setState(() => userMessage = value);
              },
              onPressedSend: () {
                print(userMessage);
                _firestore.collection('messages').add({
                  'sender' : _loggedUser.email,
                  'text' : userMessage
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
