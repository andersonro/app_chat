import 'package:app_chat/models/user_model.dart';
import 'package:app_chat/views/room_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../viewmodels/login_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginViewModel controller = Get.put(LoginViewModel());

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nicknameController = TextEditingController();

  saveUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        UserModel user = UserModel(
          nickname: _nicknameController.text,
          userId: Uuid().v4(),
        );
        user = await controller.addUser(user);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Usuário cadastrado com sucesso!')),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => RoomSelectionScreen(userModel: user),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Erro: $e')));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _nicknameController,
                decoration: const InputDecoration(
                  hintText: 'Apelido',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  if (newValue == null) {
                    _nicknameController.text = newValue!;
                  }
                },
              ),
              ElevatedButton(
                onPressed: () {
                  saveUser();
                },
                child: Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
