import 'package:app_chat/models/room_model.dart';
import 'package:app_chat/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/message_model.dart';
import '../repositories/message_repository.dart';

class ChatViewModel extends GetxController {
  final MessageRepository messageRepository = MessageRepository();
  final messages = <MessageModel>[].obs;
  final messageText = ''.obs;

  Stream<List<MessageModel>> getMessages(String roomId) {
    return messageRepository.getMessages(roomId);
  }

  Future<void> sendMessage(RoomModel roomModel, UserModel userModel) async {
    final message = MessageModel(
      userModel: userModel,
      roomModel: roomModel,
      text: messageText.value,
      timestamp: Timestamp.now(),
    );
    await messageRepository.sendMessage(roomModel.roomId, message);
    messageText.value = '';
  }
}
