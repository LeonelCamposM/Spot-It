import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/players/i_player_repository.dart';
import 'package:spot_it_game/domain/players/player.dart';
import 'package:spot_it_game/infrastructure/players/eventListeners/on_players_update.dart';

class PlayerRepository implements IPlayerRepository {
  final CollectionReference<Player> _playersCollection;

  PlayerRepository(FirebaseFirestore firestore)
      : _playersCollection =
            firestore.collection('Room_Player').withConverter<Player>(
                  fromFirestore: (doc, options) => Player.fromJson(doc.data()!),
                  toFirestore: (employee, options) => employee.toJson(),
                );

  @override
  Future<String> addPlayer(Player player, String roomID) async {
    final reference = _playersCollection.doc(roomID).collection("players");
    final newPlayer = await reference.add(player.toJson());
    return newPlayer.id;
  }

  @override
  Widget onPlayersUpdate(String roomID) {
    return OnPlayersUpdate(roomID: roomID);
  }

  @override
  Future<bool> spotIt(
      String roomID, String playerOneNickname, String playerTwoNickname) async {
    final db = FirebaseFirestore.instance;

    var roomReference = db.collection('Room_Player').doc(roomID);

    var playersReference = roomReference.collection('players');
    Player winnerPlayer = Player("", "", "", 0, 0);
    var snapshots = await playersReference.get();

    for (var doc in snapshots.docs) {
      final query = await doc.reference.get();
      Map<String, dynamic> data = query.data()!;

      if (data['nickname'] == playerOneNickname) {
        winnerPlayer = Player(data['nickname'], data["icon"],
            data["displayedCard"], data["cardCount"], data["stackCardsCount"]);
        Player newPlayer = Player(
            winnerPlayer.nickname,
            winnerPlayer.icon,
            "QuestionMark,QuestionMark,QuestionMark,QuestionMark,QuestionMark,QuestionMark,QuestionMark,QuestionMark",
            0,
            0);
        await doc.reference.update(newPlayer.toJson());
        break;
      }
    }

    for (var doc in snapshots.docs) {
      final query = await doc.reference.get();
      Map<String, dynamic> data = query.data()!;

      if (data['nickname'] == playerTwoNickname) {
        Player loserPlayer = Player(data['nickname'], data["icon"],
            data["displayedCard"], data["cardCount"], data["stackCardsCount"]);
        Player newPlayer = Player(
            loserPlayer.nickname,
            loserPlayer.icon,
            winnerPlayer.displayedCard,
            loserPlayer.cardCount + winnerPlayer.cardCount,
            loserPlayer.stackCardsCount + winnerPlayer.stackCardsCount);
        await doc.reference.update(newPlayer.toJson());
      }
    }

    // await db.runTransaction((transaction) async {
    //   // final _scoreboardCollection =
    //   //     db.collection("/Room_Scoreboard/" + roomID + "/Scoreboard");
    //   DocumentSnapshot players = await transaction.get(roomReference);
    //   final winnerPlayerReference = await players.get(winnerID);
    //   final loserPlayer = await players.get(loserID);

    //   transaction.update(roomReference, );
    // }).then(
    //   (value) => print("DocumentSnapshot successfully updated!"),
    //   onError: (e) => print("Error updating document $e"),
    // );
    return false;
  }
}
