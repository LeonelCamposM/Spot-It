import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/rooms/i_room_repository.dart';
import 'package:spot_it_game/domain/rooms/room.dart';

class RoomUseCase {
  final IRoomRepository roomRepository;

  RoomUseCase(this.roomRepository);

  Future<String> createRoom(Room room) async {
    return roomRepository.createRoom(room);
  }

  Widget onJoinableUpdate(String roomID) {
    return roomRepository.onJoinableUpdate(roomID);
  }

  Future<void> updateJoinable(roomID) async {
    return roomRepository.updateJoinable(roomID);
  }
}
