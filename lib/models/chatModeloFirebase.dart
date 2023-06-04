import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String user1;
  final String user2;

  Chat({
    required this.user1,
    required this.user2,
  });

  Chat copyWith({
    String? user1,
    String? user2,
  }) {
    return Chat(
      user1: user1 ?? this.user1,
      user2: user2 ?? this.user2,
    );
  }

  factory Chat.fromSnapshot(QueryDocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Chat(
      user1: data['user1'],
      user2: data['user2'],
    );
  }
}
