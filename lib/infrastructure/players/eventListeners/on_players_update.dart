import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/application/rooms/rooms_use_case.dart';
import 'package:spot_it_game/domain/players/player.dart';
import 'package:spot_it_game/infrastructure/rooms/eventListeners/on_joinable_update.dart';
import 'package:spot_it_game/infrastructure/rooms/rooms_repository.dart';
import 'package:spot_it_game/presentation/core/focus_box.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/core/text_button_style.dart';
import 'package:spot_it_game/presentation/game_root/game_root.dart';
import 'package:spot_it_game/presentation/waiting_room/colors.dart';
import 'package:spot_it_game/presentation/waiting_room/waiting_room.dart';

// ignore: must_be_immutable
class OnPlayersUpdate extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var args;
  Function setParentState;
  late Stream<QuerySnapshot> _usersStream;
  OnPlayersUpdate({Key? key, required this.args, required this.setParentState})
      : super(key: key) {
    _usersStream = FirebaseFirestore.instance
        .collection('/Room_Player/' + args.roomID + '/players')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    RoomUseCase roomUseCase =
        RoomUseCase(RoomRepository(FirebaseFirestore.instance));
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(child: Text(''));
        }

        List<Player> players = getAllPlayers(snapshot);
        return Padding(
          padding: const EdgeInsets.only(top: 50),
          child: getFocusBox(
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Room ID
                  getIDBanner(args.roomID),
                  getPlayersList(players),
                  Center(
                      child: args.isHost == true
                          ? players.length > 1
                              ? getTextButton(
                                  "COMENZAR",
                                  SizeConfig.safeBlockHorizontal * 20,
                                  SizeConfig.safeBlockVertical * 10,
                                  SizeConfig.safeBlockHorizontal * 2,
                                  getSecondaryColor(), () {
                                  setParentState(NavigationState.game, null);
                                  roomUseCase.updateJoinable(args.roomID);
                                })
                              : const Text("Esperando a jugadores")
                          : OnJoinableUpdate(
                              roomID: args.roomID,
                              icon: args.icon,
                              isHost: args.isHost,
                              playerNickName: args.playerNickName,
                              setParentState: setParentState))
                ],
              ),
              SizeConfig.safeBlockVertical * 85,
              SizeConfig.safeBlockHorizontal * 50),
        );
      },
    );
  }
}

// @param snapshot: enventListener on database
// @return updated player on db
List<Player> getAllPlayers(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
  // Get all chat messages from snapshot
  List<Player> players = [];
  ListView(
    children: snapshot.data!.docs
        .map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          players.add(Player(data['nickname'], data["icon"], '', 0, 0));
        })
        .toList()
        .cast(),
  );

  return players;
}
