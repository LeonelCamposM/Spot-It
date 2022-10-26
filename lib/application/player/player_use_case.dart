import 'package:spot_it_game/domain/players/i_player_repository.dart';
import 'package:spot_it_game/domain/players/player.dart';

class PlayerUseCase {
  final IPlayerRepository playerRepository;
  PlayerUseCase(this.playerRepository);

  Future<String> addPlayer(Player player, String roomID) {
    return playerRepository.addPlayer(player, roomID);
  }

  Future<List<Player>> getPlayers(String roomID) {
    return playerRepository.getPlayers(roomID);
  }
}
