import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderID;
  final String receiverID;
  final String content;
  final DateTime timestamp;
  final bool isRead;

  Message({
    required this.senderID,
    required this.receiverID,
    required this.content,
    required this.timestamp,
    this.isRead = false,
  });

  Message.fromSnapshot(DocumentSnapshot snapshot)
      : senderID = snapshot['senderID'],
        receiverID = snapshot['receiverID'],
        content = snapshot['content'],
        timestamp = snapshot['timestamp'].toDate(),
        isRead = snapshot['isRead'];

  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'receiverID': receiverID,
      'content': content,
      'timestamp': timestamp,
      'isRead': isRead,
    };
  }
}
