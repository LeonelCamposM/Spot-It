import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/rooms/i_room_repository.dart';
import 'package:spot_it_game/domain/rooms/room.dart';

class RoomUseCase {
  final IRoomRepository roomRepository;

  RoomUseCase(this.roomRepository);

  Future<String> createRoom(Room room) {
    return roomRepository.createRoom(room);
  }

  Widget onChatUpdate() {
    return roomRepository.onJoinableUpdate();
  }
}
