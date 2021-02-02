import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = 'chat-screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Group Chat India'),
          actions: [
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                })
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Firestore.instance
                .collection('chats/nxEMBv4ZOKmLlvhdY4rH/messages')
                .add({'text': 'Are you going school?'});
          },
          icon: Icon(Icons.add),
          label: Text('create your group'),
        ),
        body: StreamBuilder(
            stream: Firestore.instance
                .collection('chats/nxEMBv4ZOKmLlvhdY4rH/messages')
                .snapshots(),
            builder: (context, snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              final documents = snapShot.data.documents;
              return ListView.builder(
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    documents[index]['text'],
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                itemCount: documents.length,
              );
            }));
  }
}
