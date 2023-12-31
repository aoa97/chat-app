import 'package:intl/intl.dart';

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
    roomId = "private_${otherId}_$myId";
  } else {
    roomId = 'private_${myId}_$otherId';
  }

  return roomId;
}

String? extractOtherId(String roomId, String myId) {
  final regex = RegExp(r'^private_(?:' + myId + r'|([^_]+))_(?:' + myId + r'|([^_]+))$');
  final match = regex.firstMatch(roomId);
  if (match != null) {
    if (match.group(1) != null) return match.group(1);
    if (match.group(2) != null) return match.group(2);
  }
  return null;
}

String renderDay(DateTime dateTime) {
  var date = DateTime(dateTime.year, dateTime.month, dateTime.day);
  var now = DateTime.now();
  var today = DateTime(now.year, now.month, now.day);
  var yesterday = DateTime(now.year, now.month, now.day - 1);

  if (date == today) {
    return "Today";
  }

  if (date == yesterday) {
    return "Yesteday";
  }

  return DateFormat('MMM d, yyyy').format(dateTime);
}

String renderTime(DateTime dateTime) {
  final day = renderDay(dateTime);
  final time = DateFormat('h:mm a').format(dateTime);
  return "$day $time";
}
