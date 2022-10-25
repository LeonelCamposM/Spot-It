import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/players/player.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/waiting_room/waiting_room.dart';

// ignore: must_be_immutable
class OnPlayersUpdate extends StatelessWidget {
  String roomID;
  late Stream<QuerySnapshot> _usersStream;
  OnPlayersUpdate({Key? key, required this.roomID}) : super(key: key) {
    _usersStream = FirebaseFirestore.instance
        .collection('/Room_Player/' + roomID + '/players')
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
          return const SizedBox(child: Text(''));
        }

        List<Player> messages = getAllPlayers(snapshot);
        return getPlayersList(messages);
      },
    );
  }
}

// @param snapshot: enventListener on database
// @return updated player on db
List<Player> getAllPlayers(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
  // Get all chat messages from snapshot
  List<Player> messages = [];
  ListView(
    children: snapshot.data!.docs
        .map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          messages.add(Player(data['nickname'], data["icon"], '', 0, 0));
        })
        .toList()
        .cast(),
  );

  return messages;
}
