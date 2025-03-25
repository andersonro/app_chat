import 'package:app_chat/models/room_model.dart';
import 'package:app_chat/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final UserModel userModel;
  final RoomModel roomModel;
  final String text;
  final Timestamp timestamp;

  MessageModel({
    required this.userModel,
    required this.roomModel,
    required this.text,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'userModel': userModel,
      'roomModel': roomModel,
      'text': text,
      'timestamp': timestamp,
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      userModel: json['userModel'],
      roomModel: json['roomModel'],
      text: json['text'],
      timestamp: json['timestamp'],
    );
  }
}
