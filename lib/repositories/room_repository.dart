import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/room_model.dart';

class RoomRepository {
  final CollectionReference roomsCollection = FirebaseFirestore.instance
      .collection('rooms');

  Future<List<RoomModel>> getRooms() async {
    final querySnapshot = await roomsCollection.get();
    return querySnapshot.docs
        .map((doc) => RoomModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
