import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/rooms/i_room_repository.dart';
import 'package:spot_it_game/domain/rooms/room.dart';

class RoomUseCase {
  final IRoomRepository roomRepository;

  RoomUseCase(this.roomRepository);

  Future<String> createRoom(Room room) async {
    return roomRepository.createRoom(room);
  }

  void onJoinableUpdate(BuildContext context) async {
    return roomRepository.onJoinableUpdate(context);
  }

  Future<void> updateJoinable(roomID) async {
    return roomRepository.updateJoinable(roomID);
  }
}
