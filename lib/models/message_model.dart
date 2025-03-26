import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String userId;
  final String nickname;
  final String roomId;
  final String text;
  final DateTime timestamp;

  MessageModel({
    required this.userId,
    required this.nickname,
    required this.roomId,
    required this.text,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'nickname': nickname,
      'roomId': roomId,
      'text': text,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      userId: json['userId'],
      nickname: json['nickname'],
      roomId: json['roomId'],
      text: json['text'],
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }
}
