import 'package:app_chat/models/user_model.dart';
import 'package:get/get.dart';
import '../repositories/user_repository.dart';

class LoginViewModel extends GetxController {
  final UserRepository userRepository = UserRepository();

  final _state = StateUsers.initial.obs;
  Rx<StateUsers> get getState => _state.value.obs;
  set setState(StateUsers state) => _state.value = state;

  Future<UserModel> addUser(UserModel userModel) async {
    setState = StateUsers.loading;
    await userRepository.addUser(userModel);
    setState = StateUsers.success;
    return userModel;
  }

  Future<void> getUser(String userId) async {
    setState = StateUsers.loading;
    await userRepository.getUser(userId);
    setState = StateUsers.success;
  }
}

enum StateUsers { initial, loading, success, error }
