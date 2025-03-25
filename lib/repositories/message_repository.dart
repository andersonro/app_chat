import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message_model.dart';

class MessageRepository {
  CollectionReference messagesCollection(String roomId) {
    return FirebaseFirestore.instance
        .collection('rooms')
        .doc(roomId)
        .collection('messages');
  }

  Stream<List<MessageModel>> getMessages(String roomId) {
    return messagesCollection(roomId)
        .orderBy('timestamp', descending: true)
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

  Future<void> sendMessage(String roomId, MessageModel message) async {
    await messagesCollection(roomId).add(message.toJson());
  }
}
