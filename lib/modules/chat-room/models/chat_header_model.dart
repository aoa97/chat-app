class ChatHeaderModel {
  final String? uid;
  final String name;
  final String avatar;

  ChatHeaderModel({
    this.uid,
    required this.name,
    required this.avatar,
  });

  factory ChatHeaderModel.fromMap(Map<String, dynamic> map) {
    return ChatHeaderModel(
      name: map['name'],
      avatar: map['avatar'],
    );
  }

  ChatHeaderModel copyWith({
    String? uid,
    String? name,
    String? avatar,
  }) {
    return ChatHeaderModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
    );
  }

  @override
  bool operator ==(covariant ChatHeaderModel other) {
    if (identical(this, other)) return true;
    return other.uid == uid && other.name == name && other.avatar == avatar;
  }

  @override
  int get hashCode => uid.hashCode ^ name.hashCode ^ avatar.hashCode;
}
