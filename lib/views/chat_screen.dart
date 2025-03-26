import 'package:app_chat/models/room_model.dart';
import 'package:app_chat/models/user_model.dart';
import 'package:app_chat/views/drawer_screen.dart';
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
  final ScrollController _sc = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();

  sendMessage() async {
    debugPrint('sendMessage ${_textEditingController.text}');
    if (_textEditingController.text.isNotEmpty) {
      await controller.sendMessage(
        userModel: widget.userModel,
        roomModel: widget.roomModel,
        text: _textEditingController.text,
      );
      _textEditingController.clear();
    }
  }

  @override
  void initState() {
    super.initState();
    loadMessages();
  }

  loadMessages() async {
    await controller.getMessages2(widget.roomModel.roomId);
  }

  // Substitua pelo nickname do usuário real
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.userModel.nickname),
            Text(
              'Sala: ${widget.roomModel.name}',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        centerTitle: true,
      ),
      drawer: DrawerScreen(userModel: widget.userModel),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: StreamBuilder<List<MessageModel>>(
              stream: controller.getMessages(widget.roomModel.roomId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final messages = snapshot.data!.reversed.toList();

                  return ListView.builder(
                    controller: _sc,
                    shrinkWrap: true,
                    reverse: false,
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
    final isMe = message.userId == widget.userModel.userId;
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
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    message.nickname,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(message.text),
                  Text(
                    DateFormat(
                      'HH:mm:ss',
                    ).format(message.timestamp), // Formata a hora
                    style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
                  ),
                ],
              ),
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
              controller: _textEditingController,
              onChanged: (value) {
                _textEditingController.text = value;
                setState(() {});
              },
              decoration: InputDecoration(hintText: 'Digite sua mensagem'),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              debugPrint('Clicou Enviando mensagem');
              sendMessage();
            },
          ),
        ],
      ),
    );
  }
}
