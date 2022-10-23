import 'package:spot_it_game/domain/players/player.dart';

abstract class IPlayerRepository {
// @param player: player to send
// @param roomID: id of the destiny room
  Future<String> addPlayer(Player player, String roomID);
}
