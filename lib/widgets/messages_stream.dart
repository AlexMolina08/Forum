import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forum/widgets/message_bubble.dart';


final _firestore = FirebaseFirestore.instance;

class MessagesStream extends StatelessWidget {

  final listViewController;
  final User loggedUser;

  MessagesStream({this.listViewController , this.loggedUser});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('messages')
          .snapshots(), // obtenemos stream de los mensajes

      builder: (context, snapshot) {
        List<MessageBubble> messageWidgets = [];

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final messages = snapshot.data.docs;

          // para cada mensaje del snapshot creamos un Text y lo añadimos a la lista que se devuelve
          for (var message in messages) {
            final String messageSender = message.data()['sender'];
            final String messageText = message.data()['text'];

            if(loggedUser.email == messageSender){

            }

            messageWidgets.add(
              MessageBubble(text: messageText, sender: messageSender),
            );
          }
          return Expanded(
            child: ListView(
              controller: listViewController,
              padding: EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 20.0),
              children: messageWidgets,
            ),
          );
        }

        // en cada llamada al builder se devuelve una columna con los nuevos mensajes actualizados
      },
    );
  }
}
