import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (context, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: const CircularProgressIndicator(),
            );
          }
          return StreamBuilder(
              stream: Firestore.instance
                  .collection('chat')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, streamSnapshot) {
                if (streamSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: const CircularProgressIndicator());
                }
                final docs = streamSnapshot.data.documents;

                return docs.length == 0
                    ? const Center(child: const Text('Start Conversation!'))
                    : ListView.builder(
                        reverse: true,
                        itemBuilder: (context, index) => MessageBubble(
                          message: docs[index]['text'],
                          createdAt: DateFormat('h:mm a')
                              .format(docs[index]['createdAt'].toDate()),
                          isMe:
                              docs[index]['userId'] == futureSnapshot.data.uid,
                          key: ValueKey(docs[index]),
                          userId: docs[index]['userId'],
                          userName: docs[index]['username'],
                          userImage: docs[index]['userImage'],
                        ),
                        itemCount: docs.length,
                      );
              });
        });
  }
}
