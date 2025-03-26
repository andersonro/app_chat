import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import '../models/message_model.dart';

class MessageRepository {
  final CollectionReference messagesCollection = FirebaseFirestore.instance
      .collection('messages');

  Stream<List<MessageModel>> getMessages(String roomId) {
    return messagesCollection
        .orderBy('timestamp', descending: true)
        .where('roomId', isEqualTo: roomId)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map(
                    (doc) => MessageModel.fromJson(
                      doc.data() as Map<String, dynamic>,
                    ),
                  )
                  .toList(),
        );
  }

  Future<List<MessageModel>> getMessages2(String roomId) async {
    var res =
        await messagesCollection
            .where('roomId', isEqualTo: roomId)
            .orderBy('timestamp')
            .get();

    List<MessageModel> messages =
        res.docs.map((doc) {
          return MessageModel.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();

    return messages;
  }

  Future<void> sendMessage(MessageModel message) async {
    try {
      await messagesCollection.add(message.toJson());
    } catch (e) {
      debugPrint('Erro ao enviar mensagem: $e');
    }
  }
}
