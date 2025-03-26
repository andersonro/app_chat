import 'package:get/get.dart';
import '../models/room_model.dart';
import '../repositories/room_repository.dart';

class RoomSelectionViewModel extends GetxController {
  final RoomRepository roomRepository = RoomRepository();
  final rooms = <RoomModel>[].obs;

  final _state = StateRoom.initial.obs;
  Rx<StateRoom> get getState => _state.value.obs;
  set setState(StateRoom state) => _state.value = state;

  @override
  void onInit() {
    super.onInit();
    fetchRooms();
  }

  Future<void> fetchRooms() async {
    setState = StateRoom.loading;
    rooms.value = await roomRepository.getRooms();
    rooms.refresh();
    setState = StateRoom.success;
  }
}

enum StateRoom { initial, loading, success, error }
