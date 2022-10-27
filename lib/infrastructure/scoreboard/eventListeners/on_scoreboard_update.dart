import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/scoreboard/scoreboard.dart';
import 'package:spot_it_game/presentation/game/game.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';

// ignore: must_be_immutable
class OnScoreboardUpdate extends StatelessWidget {
  String roomID;
  late Stream<QuerySnapshot> _usersStream;
  OnScoreboardUpdate({Key? key, required this.roomID}) : super(key: key) {
    _usersStream = FirebaseFirestore.instance
        .collection("/Room_Scoreboard/" + roomID + "/Scoreboard")
        .snapshots();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
              height: SizeConfig.blockSizeVertical * 12,
              width: SizeConfig.blockSizeHorizontal * 18,
              child: const Text(''));
        }

        List<Scoreboard> scoreboardList = getAllScores(snapshot);
        return getScoreboardList(scoreboardList);
      },
    );
  }
}

// @param snapshot: EventListener on database
// @return list of the scoreboard sorted by score of the players
List<Scoreboard> getAllScores(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
  // Get all the scores from players
  List<Scoreboard> scoreboard = [];
  ListView(
    children: snapshot.data!.docs
        .map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          scoreboard.add(Scoreboard(data['nickname'], data["score"]));
        })
        .toList()
        .cast(),
  );

  // Sort scoreboard by score of the players
  scoreboard.sort((a, b) => a.score.compareTo(b.score));
  List<Scoreboard> sorted = [];
  for (var element in scoreboard) {
    sorted.add(element);
  }
  return sorted;
}
