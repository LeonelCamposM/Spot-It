import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spot_it_game/domain/scoreboard/i_scoreboard_repository.dart';
import 'package:spot_it_game/domain/scoreboard/scoreboard.dart';

class ScoreboardRepository implements IScoreboardRepository {
  final CollectionReference<Scoreboard> _scoreboardCollection;

  ScoreboardRepository(FirebaseFirestore firestore)
      : _scoreboardCollection = firestore
            .collection('Room_Scoreboard')
            .withConverter<Scoreboard>(
              fromFirestore: (doc, options) => Scoreboard.fromJson(doc.data()!),
              toFirestore: (employee, options) => employee.toJson(),
            );

  @override
  Future<String> createScoreboard(String roomID, Scoreboard scoreboard) async {
    /*
    Si se hace para crear el scoreboard por primera vez
      _scoreboardCollection.add(scoreboard);
    */

    final reference =
        _scoreboardCollection.doc(roomID).collection("scoreboard");
    final newScoreboard = await reference.add(scoreboard.toJson());
    return newScoreboard.id;
  }

  @override
  Future<void> updateScore(String roomID, String nickname, int score) async {
    await _scoreboardCollection
        .doc(roomID)
        .update(Scoreboard(nickname, score).toJson());
  }
}
