import 'package:flutter/material.dart';

class MessageBubbleModel {
  final String message;
  final String createdAt;
  final bool isMe;
  final Key key;
  final String userId;
  final String userName;
  final String userImage;
  MessageBubbleModel(
      {this.message,
      this.createdAt,
      this.isMe,
      this.key,
      this.userId,
      this.userName,
      this.userImage});
}
