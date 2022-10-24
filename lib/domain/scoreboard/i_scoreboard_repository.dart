import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/scoreboard/scoreboard.dart';

abstract class IScoreboardRepository {
  //Este no sé si es necesario
  Future<String> createScoreboard(String roomID, Scoreboard scoreboard);

  // @param roomID: the ID of the current room
  // @param scoreID: the ID of the player scoreboard
  // @param scoreboard: the new scoreboard of the player
  // @brief: Update the score of a player
  Future<void> updateScore(
      String roomID, String scoreID, Scoreboard scoreboard);

  // @brief: EventListener waiting for updates on the scoreboard
  // @return Widget: to be defined
  Widget onScoreboardUpdate();
}
