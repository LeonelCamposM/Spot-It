import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/players/i_player_repository.dart';
import 'package:spot_it_game/domain/players/player.dart';
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
  Future<bool> spotIt(String roomID, List<String> cardOneInformation,
      List<String> cardTwoInformation) async {
    bool response = true;
    final db = FirebaseFirestore.instance;

    // Players references
    var playersReference =
        db.collection('Room_Player').doc(roomID).collection('players');
    var players = await playersReference.get();
    var winnerDoc = players.docs
        .where((element) => element.data()['nickname'] == cardOneInformation[0])
        .first;
    var looserDoc = players.docs
        .where((element) => element.data()['nickname'] == cardTwoInformation[0])
        .first;

    var winnerReference = playersReference.doc(winnerDoc.id);
    var looserReference = playersReference.doc(looserDoc.id);

    // Scoreboard references
    var scoreboardReference =
        db.collection('Room_Scoreboard').doc(roomID).collection('Scoreboard');
    var scoreboards = await scoreboardReference.get();
    var scoreWinnerDoc = scoreboards.docs
        .where((element) => element.data()['nickname'] == cardOneInformation[0])
        .first;

    var roomDoc = db.collection("Room").doc(roomID);

    var scoreWinnerReference = scoreboardReference.doc(scoreWinnerDoc.id);

    db.runTransaction((transaction) async {
      // Get players snapshot
      DocumentSnapshot winnerSnapshot = await transaction.get(winnerReference);
      DocumentSnapshot looserSnapshot = await transaction.get(looserReference);

      // Get winner scoreboard snapshot
      DocumentSnapshot scoreWinnerSnapshot =
          await transaction.get(scoreWinnerReference);

      if (winnerSnapshot.exists &&
          looserSnapshot.exists &&
          scoreWinnerSnapshot.exists) {
        Player winner =
            Player.fromJson(winnerSnapshot.data() as Map<String, dynamic>);
        Player looser =
            Player.fromJson(looserSnapshot.data() as Map<String, dynamic>);
        Scoreboard winnerScoreboard = Scoreboard.fromJson(
            scoreWinnerSnapshot.data() as Map<String, dynamic>);

        bool winnerCard = winner.displayedCard == cardOneInformation[1];
        bool looserCard = looser.displayedCard == cardTwoInformation[1];
        bool emptyWinner = winner.displayedCard.contains('empty,empty');
        bool emptyLooser = looser.displayedCard.contains('empty,empty');

        bool validMovement = winnerCard && looserCard;
        if (validMovement && !emptyWinner && !emptyLooser) {
          // Update players
          transaction.update(winnerReference, {
            "displayedCard": "empty,empty,empty,empty,empty,empty,empty,empty",
            "cardCount": 0
          });
          transaction.update(looserReference,
              {"displayedCard": winner.displayedCard, "cardCount": 2});
          transaction.update(
              scoreWinnerReference, {"score": winnerScoreboard.score + 1});
          transaction.update(roomDoc, {"updatedRound": false});
        } else {
          response = false;
        }
      }
    });
    return response;
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
