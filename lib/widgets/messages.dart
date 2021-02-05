import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: const CircularProgressIndicator());
          }
          final docs = streamSnapshot.data.docs;

          return docs.length == 0
              ? const Center(child: const Text('Start Conversation!'))
              : ListView.builder(
                  reverse: true,
                  itemBuilder: (context, index) => MessageBubble(
                    message: docs[index].data()['text'],
                    createdAt: DateFormat('h:mm a')
                        .format(docs[index].data()['createdAt'].toDate()),
                    isMe: docs[index].data()['userId'] == user.uid,
                    key: ValueKey(docs[index].id),
                    userId: docs[index].data()['userId'],
                    userName: docs[index].data()['username'],
                    userImage: docs[index].data()['userImage'],
                  ),
                  itemCount: docs.length,
                );
        });
  }
}
