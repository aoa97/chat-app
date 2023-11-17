import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessageModel {
  final String? id;
  final String? senderId;
  final DateTime? createdAt;
  final String? text;
  final bool? isMe;

  ChatMessageModel({
    this.id,
    this.senderId,
    this.createdAt,
    required this.text,
    this.isMe,
  });

  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    return ChatMessageModel(
      senderId: map['senderId'],
      createdAt: map["createdAt"] != null ? (map["createdAt"] as Timestamp).toDate() : null,
      text: map['text'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'text': text,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  ChatMessageModel copyWith({
    String? id,
    String? senderId,
    DateTime? createdAt,
    String? text,
    bool? isMe,
  }) {
    return ChatMessageModel(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      createdAt: createdAt ?? this.createdAt,
      text: text ?? this.text,
      isMe: isMe ?? this.isMe,
    );
  }

  @override
  bool operator ==(covariant ChatMessageModel other) {
    if (identical(this, other)) return true;
    return other.id == id &&
        other.senderId == senderId &&
        other.createdAt == createdAt &&
        other.text == text &&
        other.isMe == isMe;
  }

  @override
  int get hashCode {
    return id.hashCode ^ senderId.hashCode ^ createdAt.hashCode ^ text.hashCode ^ isMe.hashCode;
  }
}
