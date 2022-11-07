import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/rooms/room.dart';

abstract class IRoomRepository {
  Future<String> createRoom(Room room);

  // @brief: Update joinable property of a Room
  Future<void> updateJoinable(String roomID);

  // @brief: enventListener waiting for changes on joinable property of a Room
  // it redirects the user to game page
  Widget onJoinableUpdate(String roomID, String icon, String playerNickName);
}
