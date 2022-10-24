import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/scoreboard/scoreboard.dart';
import 'package:spot_it_game/presentation/game/game.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';

class OnScoreboardUpdate extends StatefulWidget {
  const OnScoreboardUpdate({Key? key}) : super(key: key);
  @override
  State<OnScoreboardUpdate> createState() => _OnScoreboardUpdateState();
}

// @brief EventListener waiting for changes on scoreboard collection
// @return sorted by timestamp list of messages
class _OnScoreboardUpdateState extends State<OnScoreboardUpdate> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection("/Room_Scoreboard/jTKFlTMyk0Rw24pdPcmv/Scoreboard")
      .snapshots();

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

        List<Scoreboard> scoreboardList = getAllMessages(snapshot);
        return getScoreboardList(scoreboardList);
      },
    );
  }
}

// @param snapshot: EventListener on database
// @return list of the scoreboard sorted by score of the players
List<Scoreboard> getAllMessages(
    AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
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
