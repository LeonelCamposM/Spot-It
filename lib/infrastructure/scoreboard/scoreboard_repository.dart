import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/scoreboard/i_scoreboard_repository.dart';
import 'package:spot_it_game/domain/scoreboard/scoreboard.dart';
import 'package:spot_it_game/infrastructure/scoreboard/eventListeners/on_scoreboard_update.dart';

class ScoreboardRepository implements IScoreboardRepository {
  final CollectionReference<Scoreboard> _scoreboardCollection;

  ScoreboardRepository(FirebaseFirestore firestore)
      : _scoreboardCollection = firestore
            .collection('Room_Scoreboard')
            .withConverter<Scoreboard>(
              fromFirestore: (doc, options) => Scoreboard.fromJson(doc.data()!),
              toFirestore: (scoreboard, options) => scoreboard.toJson(),
            );

  @override
  Future<String> createScoreboard(String roomID, Scoreboard scoreboard) async {
    final reference =
        _scoreboardCollection.doc(roomID).collection("Scoreboard");
    final newScoreboard = await reference.add(scoreboard.toJson());
    return newScoreboard.id;
  }

  @override
  Future<void> updateScore(
      String roomID, String scoreID, Scoreboard scoreboard) async {
    final reference =
        _scoreboardCollection.doc(roomID).collection("Scoreboard").doc(scoreID);
    reference.update(scoreboard.toJson());
  }

  @override
  Future<Iterable<Scoreboard>> getFinalScoreboard(String roomID) async {
    /*final result =
        await _scoreboardCollection.doc(roomID).collection("Scoreboard").get();
    return result.docs.map((snapshot) => snapshot.data().);*/
    Iterable<Scoreboard> result = [];
    result = FirebaseFirestore.instance
        .collection("Room_Scoreboard")
        .doc(roomID)
        .collection("Scoreboard")
        .get()
        .then(
          (value) => print(value.docs.first.data()),
          onError: (e) => print("Error completing: $e"),
        ) as Iterable<Scoreboard>;

    return result;
  }

  @override
  Widget onScoreboardUpdate() {
    return const OnScoreboardUpdate();
  }
}
