class UserModel {
  final String uid;
  final String name;
  final String email;
  final String? avatar;
  final String? bio;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.avatar,
    required this.bio,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? avatar,
    String? bio,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      bio: bio ?? this.bio,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'avatar': avatar,
      'bio': bio,
    };
  }

  factory UserModel.fromMap({required Map<String, dynamic> map, required uid}) {
    return UserModel(
      uid: uid ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      avatar: map['avatar'],
      bio: map['bio'],
    );
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, email: $email, avatar: $avatar, bio: $bio)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.avatar == avatar &&
        other.bio == bio;
  }

  @override
  int get hashCode {
    return uid.hashCode ^ name.hashCode ^ email.hashCode ^ avatar.hashCode ^ bio.hashCode;
  }
}
