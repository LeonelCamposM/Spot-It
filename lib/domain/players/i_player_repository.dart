import 'package:flutter/cupertino.dart';
import 'package:spot_it_game/domain/players/player.dart';

abstract class IPlayerRepository {
// @param player: player to send
// @param roomID: id of the destiny room
  Future<String> addPlayer(Player player, String roomID);
  Widget onPlayersUpdate(String roomID);
  Future<bool> spotIt(String roomID, List<String> cardOneInformation,
      List<String> cardTwoInformation);
  Future<List<Player>> getPlayers(String roomID);
}
