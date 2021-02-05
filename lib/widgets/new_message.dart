import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewMesaage extends StatefulWidget {
  @override
  _NewMesaageState createState() => _NewMesaageState();
}

class _NewMesaageState extends State<NewMesaage> {
  var _enteredMessage = '';
  var textController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  void _sendMessage() async {
    textController.clear();
    FocusScope.of(context).unfocus();
    final currentUser = await FirebaseAuth.instance.currentUser();
    final userData = await Firestore.instance
        .collection('users')
        .document(currentUser.uid)
        .get();
    await Firestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': currentUser.uid,
      'username': userData['username'],
      'userImage': userData['user_image']
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 6, bottom: 6),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            textCapitalization: TextCapitalization.sentences,
            controller: textController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(labelText: 'Send a Message...'),
            onChanged: (value) {
              setState(() {
                _enteredMessage = value;
              });
            },
          )),
          CupertinoButton(
              child: const Icon(CupertinoIcons.chevron_right_circle_fill),
              onPressed: textController.text.trim().isEmpty
                  ? null
                  : () {
                      _sendMessage();
                    })
        ],
      ),
    );
  }
}
