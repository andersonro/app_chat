import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
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

  final List<RoomModel> arrRooms = [
    RoomModel(
      roomId: Uuid().v1(),
      name: 'Cidade',
      imageUrl:
          'https://img.freepik.com/vetores-premium/icone-preto-e-branco-da-cidade-no-fundo-branco_925480-77.jpg?w=360',
    ),
    RoomModel(
      roomId: Uuid().v1(),
      name: 'Esportes',
      imageUrl:
          'https://static.vecteezy.com/ti/vetor-gratis/p1/20822413-conjunto-do-icones-sobre-esportes-vetor.jpg',
    ),
    RoomModel(
      roomId: Uuid().v1(),
      name: 'Profissões',
      imageUrl:
          'https://st4.depositphotos.com/34939642/39225/v/450/depositphotos_392257492-stock-illustration-collection-various-occupation-design-vector.jpg',
    ),
  ];

  Future<void> fetchRooms() async {
    setState = StateRoom.loading;
    //rooms.value = await roomRepository.getRooms();
    Future.delayed(Duration(seconds: 3), () {
      rooms.value = arrRooms;
      setState = StateRoom.success;
    });
  }
}

enum StateRoom { initial, loading, success, error }
