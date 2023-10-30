bool checkPattern({required String pattern, required String value}) {
  final regularCheck = RegExp(pattern);
  return regularCheck.hasMatch(value);
}

elseNull<T>({required bool condition, required T child}) {
  return condition ? child : null;
}

String generateRoomId(String myId, String otherId) {
  String roomId = "";

  if (myId.compareTo(otherId) > 0) {
    roomId = "${otherId}_$myId";
  } else {
    roomId = '${myId}_$otherId';
  }

  return roomId;
}
