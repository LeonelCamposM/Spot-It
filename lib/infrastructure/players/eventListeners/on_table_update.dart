import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/application/player/player_use_case.dart';
import 'package:spot_it_game/domain/players/player.dart';
import 'package:spot_it_game/infrastructure/players/player_repository.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/core/text_button_style.dart';
import 'package:spot_it_game/presentation/game/card_location.dart';
import 'package:spot_it_game/presentation/game/colors.dart';
import 'package:spot_it_game/presentation/game/game.dart';
import 'package:spot_it_game/presentation/scoreboard/scoreboard.dart';

// ignore: must_be_immutable
class OnTableUpdate extends StatelessWidget {
  String roomID;
  late Stream<QuerySnapshot> _usersStream;
  PlayerUseCase playerUseCase =
      PlayerUseCase(PlayerRepository(FirebaseFirestore.instance));

  OnTableUpdate({
    Key? key,
    required this.roomID,
  }) : super(key: key) {
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
          return const Text('cargando');
        }

        List<Player> players = getAllPlayers(snapshot);

        if (players.where((element) => element.cardCount == -1).length > 1) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: SizeConfig.blockSizeVertical * 50,
              ),
              getTextButton(
                  "Scoreboard",
                  SizeConfig.safeBlockHorizontal * 20,
                  SizeConfig.safeBlockVertical * 10,
                  SizeConfig.safeBlockHorizontal * 2,
                  getSecondaryColor(), () {
                Navigator.pushNamed(context, ScoreboardPage.routeName,
                    arguments: ScoreboardRoomArgs(true, roomID));
              }),
              SizedBox(
                height: 100,
              ),
            ],
          );
        } else {
          return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: getAmountOfCardsMenu(context, players, roomID));
        }
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
          players.add(Player(
              data['nickname'],
              data["icon"],
              data["displayedCard"],
              data["cardCount"],
              data["stackCardsCount"]));
        })
        .toList()
        .cast(),
  );

  return players;
}
