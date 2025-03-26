import 'package:app_chat/models/user_model.dart';
import 'package:app_chat/repositories/user_logado_repository.dart';
import 'package:app_chat/views/room_selection_screen.dart';
import 'package:app_chat/views/splash_screen.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatefulWidget {
  final UserModel userModel;
  const DrawerScreen({super.key, required this.userModel});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  late UserLogadoRepository userLogadoRepository = UserLogadoRepository();

  logout(BuildContext context) async {
    await userLogadoRepository.deleteUserLogado();
    if (context.mounted) {
      Navigator.of(context).pop();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SplashScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          SizedBox(height: 20),
          ListTile(
            title: Text('Salas'),
            leading: Icon(Icons.meeting_room),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          RoomSelectionScreen(userModel: widget.userModel),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Sair'),
            leading: Icon(Icons.logout_outlined),
            onTap: () async {
              debugPrint('Logout');
              logout(context);
            },
          ),
          // Add more ListTiles as needed
        ],
      ),
    );
  }
}
