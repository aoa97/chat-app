import 'package:cloud_firestore/cloud_firestore.dart';

class RecentChatModel {
  final String roomId;
  final String text;
  final String name;
  final String avatar;
  final DateTime? createdAt;

  RecentChatModel({
    required this.roomId,
    required this.text,
    required this.name,
    required this.avatar,
    required this.createdAt,
  });

  factory RecentChatModel.fromMap(Map<String, dynamic> map) {
    return RecentChatModel(
      roomId: map['roomId'],
      text: map['text'],
      name: map['name'],
      avatar: map['avatar'],
      createdAt: map["createdAt"] != null ? (map["createdAt"] as Timestamp).toDate() : null,
    );
  }

  RecentChatModel copyWith({
    String? roomId,
    String? text,
    String? name,
    String? avatar,
    DateTime? createdAt,
  }) {
    return RecentChatModel(
      roomId: roomId ?? this.roomId,
      text: text ?? this.text,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
