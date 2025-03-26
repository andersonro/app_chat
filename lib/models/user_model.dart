class UserModel {
  final String userId;
  final String nickname;

  UserModel({required this.nickname, required this.userId});

  Map<String, dynamic> toJson() {
    return {'nickname': nickname, 'userId': userId};
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(userId: json['userId'], nickname: json['nickname']);
  }
}
