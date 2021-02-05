import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String createdAt;
  final bool isMe;
  final Key key;
  final String userId;
  final String userName;
  final String userImage;
  MessageBubble(
      {this.message,
      this.createdAt,
      this.isMe,
      this.key,
      this.userId,
      this.userName,
      this.userImage});
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [if(!isMe)
          CircleAvatar(
            backgroundImage: NetworkImage(userImage)),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      message,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 15),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        createdAt,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    )
                  ],
                ),
              )),
              if(isMe)
          CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          )
        ]);
  }
}
