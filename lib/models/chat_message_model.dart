class ChatMessageModel {
  final String id;
  final String senderId;
  final DateTime dateTime;
  final String text;
  final bool isMe;

  ChatMessageModel({
    required this.id,
    required this.senderId,
    required this.dateTime,
    required this.text,
    required this.isMe,
  });
}

final dummyMessages = [
  ChatMessageModel(
    id: "1",
    senderId: "10",
    dateTime: DateTime(2023, 10, 18, 12, 0, 0),
    text: "Received Message",
    isMe: false,
  ),
  ChatMessageModel(
    id: "3",
    senderId: "11",
    dateTime: DateTime(2023, 10, 18, 12, 1, 0),
    text: "Sent Message",
    isMe: true,
  ),
  ChatMessageModel(
    id: "2",
    senderId: "10",
    dateTime: DateTime(2023, 10, 17, 12, 0, 0),
    text: "Received Message",
    isMe: false,
  ),
  ChatMessageModel(
    id: "4",
    senderId: "11",
    dateTime: DateTime(2023, 10, 17, 12, 1, 0),
    text: "Sent Message",
    isMe: true,
  ),
];
