import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/application/player/player_use_case.dart';
import 'package:spot_it_game/domain/players/player.dart';
import 'package:spot_it_game/domain/rooms/room.dart';
import 'package:spot_it_game/infrastructure/players/player_repository.dart';
import 'package:spot_it_game/presentation/game/card_location.dart';
import 'package:spot_it_game/presentation/game_root/game_root.dart';

// ignore: must_be_immutable
class OnTableUpdate extends StatefulWidget {
  String roomID;
  String playerNickName;
  late Stream<QuerySnapshot> _usersStream;
  bool isHost;
  Function setParentState;

  OnTableUpdate(
      {Key? key,
      required this.roomID,
      required this.playerNickName,
      required this.isHost,
      required this.setParentState})
      : super(key: key) {
    _usersStream = FirebaseFirestore.instance
        .collection('/Room_Player/' + roomID + '/players')
        .snapshots();
  }

  @override
  State<OnTableUpdate> createState() => _OnTableUpdateState();
}

class _OnTableUpdateState extends State<OnTableUpdate> {
  PlayerUseCase playerUseCase =
      PlayerUseCase(PlayerRepository(FirebaseFirestore.instance));

  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: widget._usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('');
        }

        List<Player> players = getAllPlayers(snapshot);

        bool roundCondition = players
                .where((element) =>
                    element.displayedCard.contains('SpotItLogo,SpotItLogo'))
                .length ==
            players.length - 1;

        bool startCondition = players
                .where(
                    (element) => element.displayedCard.contains('empty,empty'))
                .length ==
            players.length;

        bool stopCondition =
            players.where((element) => element.cardCount == -1).length ==
                players.length;

        if (stopCondition) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            widget.setParentState(NavigationState.scoreboardRoom, null);
          });
          return const Text("");
        }

        if ((roundCondition || startCondition) && widget.isHost) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            while (true) {
              bool result = await updateNewRound(widget.roomID);
              if (result == true) {
                break;
              } else {}
            }
          });
        }

        return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: getAmountOfCardsMenu(context, players, widget.roomID,
                widget.playerNickName, widget.isHost, widget.playerNickName));
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
          players.add(Player.fromJson(data));
        })
        .toList()
        .cast(),
  );

  return players;
}

Future<bool> updateNewRound(String roomID) async {
  bool result = false;
  final db = FirebaseFirestore.instance;
  var roomDoc = db.collection("Room").doc(roomID);

  db.runTransaction((transaction) async {
    DocumentSnapshot roomSnapshot = await transaction.get(roomDoc);
    Room roomInstance =
        Room.fromJson(roomSnapshot.data() as Map<String, dynamic>);
    if (roomInstance.updatedRound == false) {
      transaction.update(roomDoc, {
        "updatedRound": true,
        "round": roomInstance.round + 1,
        "newRound": true,
      });
    }
  });

  DocumentSnapshot roomSnapshot = await roomDoc.get();
  Room roomInstance =
      Room.fromJson(roomSnapshot.data() as Map<String, dynamic>);
  if (roomInstance.updatedRound == true) {
    result = true;
  }

  return result;
}
