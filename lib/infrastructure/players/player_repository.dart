import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/players/i_player_repository.dart';
import 'package:spot_it_game/domain/players/player.dart';
import 'package:spot_it_game/domain/rooms/room.dart';
import 'package:spot_it_game/domain/scoreboard/scoreboard.dart';
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
    var scoreboardReference =
        db.collection('Room_Scoreboard').doc('jTKFlTMyk0Rw24pdPcmv');

    var playersReference = roomReference.collection('players');
    var playerScoreboardReference =
        scoreboardReference.collection('Scoreboard');

    Player winnerPlayer = Player("", "", "", 0, 0);
    var snapshots = await playersReference.get();
    var snapshotsScoreboard = await playerScoreboardReference.get();

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

        for (var docScoreboard in snapshotsScoreboard.docs) {
          final queryScoreboard = await docScoreboard.reference.get();
          Map<String, dynamic> queryData = queryScoreboard.data()!;
          if (queryData['nickname'] == playerOneNickname) {
            Scoreboard winnerScoreboard =
                Scoreboard(queryData['nickname'], queryData['score']);
            Scoreboard newScoreboard = Scoreboard(
                winnerScoreboard.nickname, winnerScoreboard.score + 1);
            await docScoreboard.reference.update(newScoreboard.toJson());
            break;
          }
        }

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

    // Update
    final roomIDReference =
        FirebaseFirestore.instance.collection('Room').doc(roomID);
    final roomCollection = await roomIDReference.get();
    Room room = Room.fromJson(roomCollection.data()!);
    room.round = room.round + 1;
    roomIDReference.update(room.toJson());
    return false;
  }

  @override
  Future<List<Player>> getPlayers(String roomID) async {
    final collection =
        await _playersCollection.doc(roomID).collection("players").get();
    List<Player> result = [];
    collection.docs
        .map((DocumentSnapshot doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          result.add(Player(
              data['nickname'],
              data['icon'],
              data['displayedCard'],
              data['cardCount'],
              data['stackCardsCount']));
        })
        .toList()
        .cast();
    return result;
  }
}
