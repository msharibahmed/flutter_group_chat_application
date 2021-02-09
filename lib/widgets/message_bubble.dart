import 'package:flutter/material.dart';

import '../model/message_bubble_model.dart';

class MessageBubble extends StatelessWidget {
  final MessageBubbleModel bubble;
  MessageBubble({this.bubble});
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
            bubble.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!bubble.isMe)
            CircleAvatar(backgroundImage: NetworkImage(bubble.userImage)),
          Container(
              width: 170,
              decoration: BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(bubble.isMe ? 8 : 0),
                    bottomRight: Radius.circular(bubble.isMe ? 0 : 8),
                  )),
              margin: const EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bubble.userName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      bubble.message,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 15),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        bubble.createdAt,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    )
                  ],
                ),
              )),
          if (bubble.isMe)
            CircleAvatar(
              backgroundImage: NetworkImage(bubble.userImage),
            )
        ]);
  }
}
