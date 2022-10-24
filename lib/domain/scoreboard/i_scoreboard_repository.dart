import 'package:spot_it_game/domain/scoreboard/scoreboard.dart';

abstract class IScoreboardRepository {
  //Este no sé si es necesario
  Future<String> createScoreboard(String roomID, Scoreboard scoreboard);

  // @param nickname: the nickname of the player
  // @param score: the new score of the player
  // @brief: Update the score of a player
  Future<void> updateScore(String roomID, String nickname, int score);
}
