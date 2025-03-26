import 'package:app_chat/models/room_model.dart';
import 'package:app_chat/models/user_model.dart';
import 'package:get/get.dart';
import '../models/message_model.dart';
import '../repositories/message_repository.dart';

class ChatViewModel extends GetxController {
  final MessageRepository messageRepository = MessageRepository();
  final messages = <MessageModel>[].obs;

  final _state = MessageState.init.obs;
  Rx<MessageState> get getState => _state.value.obs;
  set setState(MessageState state) => _state.value = state;

  Stream<List<MessageModel>> getMessages(String roomId) {
    setState = MessageState.loading;
    return messageRepository.getMessages(roomId);
    ////messages.value = arrMessages;
    //messages.refresh();
    //setState = MessageState.success;
    //return Stream.value(messages);
  }

  Future<List<MessageModel>> getMessages2(String roomId) async {
    setState = MessageState.loading;
    var res = await messageRepository.getMessages2(roomId);
    messages.value = res;
    messages.refresh();
    setState = MessageState.success;
    return messages;
  }

  Future<void> sendMessage({
    required RoomModel roomModel,
    required UserModel userModel,
    required String text,
  }) async {
    MessageModel message = MessageModel(
      userId: userModel.userId,
      nickname: userModel.nickname,
      roomId: roomModel.roomId,
      text: text,
      timestamp: DateTime.now(),
    );
    await messageRepository.sendMessage(message);
  }
}

enum MessageState { init, loading, success, error }
