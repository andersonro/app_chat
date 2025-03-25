import 'package:uuid/uuid.dart';

class UserModel {
  final String? userId = Uuid().v1();
  final String nickname;

  UserModel({required this.nickname, String? userId});

  Map<String, dynamic> toJson() {
    return {'nickname': nickname, 'userId': userId};
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(userId: json['userId'], nickname: json['nickname']);
  }
}
