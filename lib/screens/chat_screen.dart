import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forum/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forum/widgets/message_bubble.dart';
import 'package:forum/widgets/chat_textfield.dart';
import 'package:forum/widgets/messages_stream.dart';

final _firestore = FirebaseFirestore.instance;
User _loggedUser;

bool isMe = false;

class ChatScreen extends StatefulWidget {
  static const String routeID = '/chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance; // instancia de firestore

  String userMessage; // Mensaje que se envia

  // *** Controlladores de widgets
  final _textFieldController = TextEditingController(); //
  final _listViewController = ScrollController();

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
  * Añade un mensaje a la colección messages
  * */
  void addMessageToCollection() {
    _firestore.collection('messages').add(
      {'sender': _loggedUser.email, 'text': userMessage},
    );
  }

  /*
  * Escucha los mensajes que van añadiendose a firestore
  * */
  void messagesStream() async {
    Stream snapshots = _firestore.collection('messages').snapshots();

    // recorremos cada snapshot (cada cambio que se hace en la base de datos)
    // es decir , que cuando se añada / elimine un mensaje de la coleccion , se llamará a este for
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
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
            MessagesStream(
              listViewController: _listViewController,
            ),
            ChatTextField(
              onChanged: (value) {
                setState(() => userMessage = value);
              },
              controller: _textFieldController,
              onPressedSend: () {
                print(userMessage);
                addMessageToCollection();
                _textFieldController
                    .clear(); // limpiamos textfield del mensaje enviado
                //vamos al final de la lista
                _listViewController
                    .jumpTo(_listViewController.position.maxScrollExtent);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  final listViewController;

  MessagesStream({this.listViewController});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('messages')
          .snapshots(), // obtenemos stream de los mensajes

      // builder se llama cada vez que entran mensajes
      builder: (context, snapshot) {
        List<MessageBubble> messageWidgets = [];

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final messages = snapshot.data
              .docs; //obtenemos los Documentos de esa colección (QueryDocumentSnapShot)

          // para cada mensaje del snapshot creamos un Text y lo añadimos a la lista que se devuelve
          for (var message in messages) {
            final String messageSender = message.data()['sender'];
            final String messageText = message.data()['text'];

            // quien es el usuario
            if (_loggedUser.email == messageSender) {
              isMe = true;
            } else {
              isMe = false;
            }

            messageWidgets.add(
              MessageBubble(
                text: messageText,
                sender: messageSender,
                color: (isMe) ? Colors.lightBlue : Colors.blueGrey,
              ),
            );
          }
          return Expanded(
            child: ListView(
              controller: listViewController,
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              children: messageWidgets,
            ),
          );
        }

        // en cada llamada al builder se devuelve una columna con los nuevos mensajes actualizados
      },
    );
  }
}
