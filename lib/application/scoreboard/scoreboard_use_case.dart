import 'package:spot_it_game/domain/scoreboard/i_scoreboard_repository.dart';
import 'package:spot_it_game/domain/scoreboard/scoreboard.dart';

class ScoreboardUseCase {
  final IScoreboardRepository scoreboardRepository;

  ScoreboardUseCase(this.scoreboardRepository);

  Future<String> createScoreboard(String roomID, Scoreboard scoreboard) async {
    return scoreboardRepository.createScoreboard(roomID, scoreboard);
  }

  Future<void> updateScore(String roomID, String nickname, int score) {
    return scoreboardRepository.updateScore(roomID, nickname, score);
  }
}
