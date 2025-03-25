class RoomModel {
  final String roomId;
  final String name;
  final String imageUrl;

  RoomModel({required this.name, required this.imageUrl, required this.roomId});

  Map<String, dynamic> toJson() {
    return {'name': name, 'imageUrl': imageUrl, 'roomId': roomId};
  }

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      roomId: json['roomId'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }
}
