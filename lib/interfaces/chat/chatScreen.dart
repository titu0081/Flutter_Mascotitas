import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'componentes/mensajes.dart';
import 'componentes/mensajesB.dart';

class ChatScreen extends StatefulWidget {
  final String userID;
  final String otherUserID;

  const ChatScreen({required this.userID, required this.otherUserID});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  late Stream<QuerySnapshot> _messagesStream;

  @override
  void initState() {
    super.initState();
    _messagesStream = _getMessagesStream();
  }

  Stream<QuerySnapshot> _getMessagesStream() {
    final collection = FirebaseFirestore.instance.collection('messages');
    return collection
        .where('chatID', isEqualTo: _getChatID())
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  String _getChatID() {
    final userID1 = widget.userID;
    final userID2 = widget.otherUserID;
    final List<String> sortedIDs = [userID1, userID2]..sort();
    return sortedIDs.join('_');
  }

  Future<void> _sendMessage(String message) async {
    final collection = FirebaseFirestore.instance.collection('messages');
    final chatID = _getChatID();

    await collection.add({
      'chatID': chatID,
      'senderID': widget.userID,
      'receiverID': widget.otherUserID,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _messagesStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final messages = snapshot.data!.docs;

                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final senderID = message['senderID'];
                      final isMe = senderID == widget.userID;
                      final messageText = message['message'];

                      return Align(
                        alignment:
                            isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.blue[100] : Colors.grey[200],
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            messageText,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    final message = _messageController.text.trim();
                    if (message.isNotEmpty) {
                      _sendMessage(message);
                    }
                  },
                  child: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
