import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/scoreboard/i_scoreboard_repository.dart';
import 'package:spot_it_game/domain/scoreboard/scoreboard.dart';

class ScoreboardUseCase {
  final IScoreboardRepository scoreboardRepository;

  ScoreboardUseCase(this.scoreboardRepository);

  Future<String> createScoreboard(String roomID, Scoreboard scoreboard) async {
    return scoreboardRepository.createScoreboard(roomID, scoreboard);
  }

  Future<void> updateScore(
      String roomID, String scoreID, Scoreboard scoreboard) {
    return scoreboardRepository.updateScore(roomID, scoreID, scoreboard);
  }

  Future<Iterable<Scoreboard>> getFinalScoreboard(String roomID) {
    return scoreboardRepository.getFinalScoreboard(roomID);
  }

  Widget onScoreboardUpdate(String roomID) {
    return scoreboardRepository.onScoreboardUpdate(roomID);
  }
}
