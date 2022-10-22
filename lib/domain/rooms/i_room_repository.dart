import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/rooms/room.dart';

abstract class IRoomRepository {
  // @brief: enventListener waiting for changes on chat
  // @return Widget: vertical list with all chat messages in order
  Future<String> createRoom(Room room);

  // @brief: enventListener waiting for changes on joinable property of a Room
  // it redirects the user to game page
  Widget onJoinableUpdate(BuildContext context);
}
