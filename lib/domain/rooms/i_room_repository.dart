import 'package:spot_it_game/domain/rooms/room.dart';

abstract class IRoomRepository {
  Future<String> createRoom(Room room);
}
