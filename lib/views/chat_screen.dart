import 'package:app_chat/models/room_model.dart';
import 'package:app_chat/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodels/chat_viewmodel.dart';
import '../models/message_model.dart';
import 'package:intl/intl.dart'; // Importe a biblioteca intl

class ChatScreen extends StatefulWidget {
  final UserModel userModel;
  final RoomModel roomModel;
  const ChatScreen({
    super.key,
    required this.userModel,
    required this.roomModel,
  });
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatViewModel controller = Get.put(ChatViewModel());

  // Substitua pelo nickname do usuário real
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.userModel.nickname),
            Text(widget.roomModel.name, style: TextStyle(fontSize: 12)),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<MessageModel>>(
              stream: controller.getMessages(widget.roomModel.roomId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final messages = snapshot.data!;
                  return ListView.builder(
                    reverse: true, // Exibe as mensagens mais recentes no final
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return _buildMessage(message);
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro ao carregar mensagens'));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildMessage(MessageModel message) {
    final isMe = message.userModel.userId == widget.userModel.userId;
    final alignment = isMe ? Alignment.centerRight : Alignment.centerLeft;
    final color = isMe ? Colors.blue[100] : Colors.grey[300];

    return Align(
      alignment: alignment,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message.userModel.nickname,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(message.text),
            Text(
              DateFormat(
                'HH:mm',
              ).format(message.timestamp.toDate()), // Formata a hora
              style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: TextEditingController.fromValue(
                TextEditingValue(text: controller.messageText.value),
              ),
              onChanged: (value) => controller.messageText.value = value,
              decoration: InputDecoration(hintText: 'Digite sua mensagem'),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              if (controller.messageText.value.isNotEmpty) {
                controller.sendMessage(widget.roomModel, widget.userModel);
              }
            },
          ),
        ],
      ),
    );
  }
}
