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
  Future<bool> spotIt(String roomID, List<String> cardOneInformation,
      List<String> cardTwoInformation) async {
    bool response = true;
    final db = FirebaseFirestore.instance;
    var playersReference =
        db.collection('Room_Player').doc(roomID).collection('players');

    Player playerUpdated = Player("", "", "", 0, 0);
    Scoreboard scoreboardUpdated = Scoreboard("", 0);

    var players = await playersReference.get();

    var winnerPlayerData = players.docs
        .where((element) => element.data()['nickname'] == cardOneInformation[0])
        .first;

    Player winnerPlayer = Player(
        winnerPlayerData['nickname'],
        winnerPlayerData["icon"],
        winnerPlayerData["displayedCard"],
        winnerPlayerData["cardCount"],
        winnerPlayerData["stackCardsCount"]);

    if (winnerPlayer.displayedCard != cardOneInformation[1]) {
      response = false;
    } else {
      var scoreboardReference =
          db.collection('Room_Scoreboard').doc(roomID).collection('Scoreboard');

      var scoreboard = await scoreboardReference.get();

      var scoreboardWinnerData = scoreboard.docs
          .where(
              (element) => element.data()['nickname'] == cardOneInformation[0])
          .first;

      var loserPlayerData = players.docs
          .where(
              (element) => element.data()['nickname'] == cardTwoInformation[0])
          .first;

      //Updated winner player and score for winner
      playerUpdated = Player(
          winnerPlayer.nickname,
          winnerPlayer.icon,
          "QuestionMark,QuestionMark,QuestionMark,QuestionMark,QuestionMark,QuestionMark,QuestionMark,QuestionMark",
          0,
          0);

      await winnerPlayerData.reference.update(playerUpdated.toJson());

      scoreboardUpdated = Scoreboard(scoreboardWinnerData.data()['nickname'],
          scoreboardWinnerData.data()['score'] + 1);
      await scoreboardWinnerData.reference.update(scoreboardUpdated.toJson());

      //Updated loser player
      playerUpdated = Player(
          loserPlayerData.data()['nickname'],
          loserPlayerData.data()['icon'],
          winnerPlayer.displayedCard,
          loserPlayerData.data()['cardCount'] + winnerPlayer.cardCount,
          loserPlayerData.data()['cardCount'] + winnerPlayer.stackCardsCount);

      await loserPlayerData.reference.update(playerUpdated.toJson());

      // Update
      final roomIDReference =
          FirebaseFirestore.instance.collection('Room').doc(roomID);
      final roomCollection = await roomIDReference.get();
      Room room = Room.fromJson(roomCollection.data()!);
      room.round = room.round + 1;
      room.newRound = room.newRound;
      roomIDReference.update(room.toJson());
    }
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
