import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String createdAt;
  final bool isMe;
  final Key key;
  MessageBubble({this.message, this.createdAt, this.isMe,this.key});
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
              width: 170,
              decoration: BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(isMe ? 8 : 0),
                    bottomRight: Radius.circular(isMe ? 0 : 8),
                  )),
              margin: const EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        message,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(width: 15),
                    Text(
                      createdAt,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    )
                  ],
                ),
              )),
        ]);
  }
}
