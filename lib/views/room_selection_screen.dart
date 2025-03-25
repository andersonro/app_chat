import 'package:app_chat/models/user_model.dart';
import 'package:app_chat/views/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodels/room_selection_viewmodel.dart';

class RoomSelectionScreen extends StatefulWidget {
  final UserModel userModel;
  const RoomSelectionScreen({super.key, required this.userModel});

  @override
  State<RoomSelectionScreen> createState() => _RoomSelectionScreenState();
}

class _RoomSelectionScreenState extends State<RoomSelectionScreen> {
  final RoomSelectionViewModel controller = Get.put(RoomSelectionViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.userModel.nickname), centerTitle: true),
      body: Obx(
        () =>
            controller.getState.value == StateRoom.success
                ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // number of items in each row
                    mainAxisSpacing: 8.0, // spacing between rows
                    crossAxisSpacing: 8.0, // spacing between columns
                  ),
                  itemCount: controller.rooms.length,
                  itemBuilder: (context, index) {
                    final room = controller.rooms[index];
                    return Card(
                      shadowColor: Colors.blue.shade800,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => ChatScreen(
                                    userModel: widget.userModel,
                                    roomModel: room,
                                  ),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              room.imageUrl,
                              fit: BoxFit.cover,
                              width: 120,
                            ),
                            Text(
                              room.name,
                              style: TextStyle(color: Colors.blue.shade800),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
                : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
