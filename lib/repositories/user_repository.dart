import 'package:app_chat/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final CollectionReference usersCollection = FirebaseFirestore.instance
      .collection('users');

  Future<UserModel> addUser(UserModel user) async {
    await usersCollection.add(user.toJson());
    UserModel userModel = await getUser(user.userId!);
    return userModel;
  }

  Future<UserModel> getUser(String userId) async {
    UserModel userModel;
    QuerySnapshot query =
        await usersCollection.where('userId', isEqualTo: userId).get();
    userModel = UserModel.fromJson(
      query.docs.first.data() as Map<String, dynamic>,
    );
    return userModel;
  }
}
