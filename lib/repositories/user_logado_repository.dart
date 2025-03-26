import 'dart:convert';

import 'package:app_chat/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLogadoRepository {
  late SharedPreferences _preferences;

  Future<bool> setUserLogado(UserModel userModel) async {
    _preferences = await SharedPreferences.getInstance();
    return await _preferences.setString('usuario', json.encode(userModel));
  }

  Future<UserModel?> getUserLogado() async {
    _preferences = await SharedPreferences.getInstance();
    String user = _preferences.getString('usuario') ?? '';
    if (user.isNotEmpty) {
      UserModel userModel = UserModel.fromJson(json.decode(user));
      return userModel;
    }
    return null;
  }

  Future<bool> deleteUserLogado() async {
    _preferences = await SharedPreferences.getInstance();
    return await _preferences.remove('usuario');
  }
}
