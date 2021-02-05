import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_group_chat_application/widgets/messages.dart';
import 'package:flutter_group_chat_application/widgets/new_message.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = 'chat-screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text('Group Chat India'),
          actions: [
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                })
          ],
        ),
        body: Container(
          child: Column(
            children: [Expanded(child: Messages()), NewMesaage()],
          ),
        ));
  }
}
