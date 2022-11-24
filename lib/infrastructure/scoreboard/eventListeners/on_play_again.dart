import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/application/player/player_use_case.dart';
import 'package:spot_it_game/application/scoreboard/scoreboard_use_case.dart';
import 'package:spot_it_game/domain/players/player.dart';
import 'package:spot_it_game/domain/rooms/room.dart';
import 'package:spot_it_game/domain/scoreboard/scoreboard.dart';
import 'package:spot_it_game/infrastructure/players/player_repository.dart';
import 'package:spot_it_game/infrastructure/scoreboard/scoreboard_repository.dart';
import 'package:spot_it_game/presentation/core/icon_button_style.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/game_root/game_root.dart';
import 'package:spot_it_game/presentation/scoreboard/colors.dart';

// ignore: must_be_immutable
class OnPlayAgain extends StatelessWidget {
  var args;
  late Stream<QuerySnapshot> _usersStream;
  Function setParentState;

  OnPlayAgain({Key? key, required this.args, required this.setParentState})
      : super(key: key) {
    _usersStream = FirebaseFirestore.instance.collection('Room').snapshots();
  }
  final List<String> messages = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('');
        }

        Room room = getUpdateRoom(snapshot, args.roomID);
        if (room.round == 0 && room.joinable == true) {
          return getIconButtonStyle(
            getSecondaryColor(),
            IconButton(
              icon: const Icon(Icons.replay),
              iconSize: getIconSize(),
              alignment: Alignment.center,
              onPressed: () {
                rejoin_game(args);
                setParentState(NavigationState.waitingRoom, null);
              },
            ),
          );
        } else {
          return const Text("");
        }
      },
    );
  }
}

// @param snapshot: enventListener on database
// @return roomID data
Room getUpdateRoom(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, roomID) {
  // Get updated room from snapshot
  List<Room> messages = [];
  ListView(
    children: snapshot.data!.docs
        .map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          if (document.id == roomID) {
            messages.add(Room.fromJson(data));
          }
        })
        .toList()
        .cast(),
  );

  return messages.first;
}

// ignore: non_constant_identifier_names
Future<void> rejoin_game(args) async {
  final playerUseCase =
      PlayerUseCase(PlayerRepository(FirebaseFirestore.instance));
  final scoreboardUseCase =
      ScoreboardUseCase(ScoreboardRepository(FirebaseFirestore.instance));
  playerUseCase.addPlayer(
      Player(args.playerNickName, args.icon,
          "empty,empty,empty,empty,empty,empty,empty,empty", 0, 0),
      args.roomID);
  scoreboardUseCase.createScoreboard(
      args.roomID, Scoreboard(args.playerNickName, 0));
}
