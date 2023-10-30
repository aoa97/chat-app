// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessageModel {
  final String? id;
  final String senderId;
  final DateTime createdAt;
  final String text;
  final bool? isMe;

  ChatMessageModel({
    this.id,
    required this.senderId,
    required this.createdAt,
    required this.text,
    this.isMe,
  });

  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    return ChatMessageModel(
      senderId: map['senderId'],
      createdAt: (map["createdAt"] as Timestamp).toDate(),
      text: map['text'],
    );
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
}

final dummyMessages = [
  ChatMessageModel(
    id: "1",
    senderId: "10",
    createdAt: DateTime(2023, 10, 18, 12, 0, 0),
    text: "Received Message",
    isMe: false,
  ),
  ChatMessageModel(
    id: "3",
    senderId: "11",
    createdAt: DateTime(2023, 10, 18, 12, 1, 0),
    text: "Sent Message",
    isMe: true,
  ),
  ChatMessageModel(
    id: "2",
    senderId: "10",
    createdAt: DateTime(2023, 10, 17, 12, 0, 0),
    text: "Received Message",
    isMe: false,
  ),
  ChatMessageModel(
    id: "4",
    senderId: "11",
    createdAt: DateTime(2023, 10, 17, 12, 1, 0),
    text: "Sent Message",
    isMe: true,
  ),
];
