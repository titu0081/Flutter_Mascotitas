import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'mensajes.dart';

class ChatBubble extends StatelessWidget {
  final Message message;
  final bool isMe;

  const ChatBubble({Key? key, required this.message, required this.isMe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bubbleAlignment =
        isMe ? MainAxisAlignment.end : MainAxisAlignment.start;
    final bubbleColor = isMe ? Colors.blue : Colors.grey.shade300;

    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Text(
            message.content,
            style: TextStyle(color: isMe ? Colors.white : Colors.black),
          ),
        ),
        Text(
          DateFormat('HH:mm').format(message.timestamp),
          style: TextStyle(fontSize: 12.0, color: Colors.grey),
        ),
      ],
    );
  }
}
