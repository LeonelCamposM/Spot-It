import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/application/player/player_use_case.dart';
import 'package:spot_it_game/application/rooms/rooms_use_case.dart';
import 'package:spot_it_game/domain/players/player.dart';
import 'package:spot_it_game/infrastructure/players/player_repository.dart';
import 'package:spot_it_game/infrastructure/rooms/eventListeners/on_joinable_update.dart';
import 'package:spot_it_game/infrastructure/rooms/rooms_repository.dart';
import 'package:spot_it_game/presentation/chat/chat.dart';
import 'package:spot_it_game/presentation/core/focus_box.dart';
import 'package:spot_it_game/presentation/core/get_children_with_icon.dart';
import 'package:spot_it_game/presentation/core/icon_button_style.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/core/text_button_style.dart';
import 'package:spot_it_game/presentation/game/game.dart';
import 'package:spot_it_game/presentation/game_root/game_root.dart';
import 'package:spot_it_game/presentation/register_room/available_icons.dart';
import 'package:spot_it_game/presentation/register_room/register_room.dart';
import 'package:spot_it_game/presentation/home/home.dart';
import 'package:flutter/services.dart';
import 'package:spot_it_game/presentation/waiting_room/colors.dart';
import 'dart:math';
import 'package:spot_it_game/presentation/waiting_room/round_config.dart';

class WaitingRoomPage extends StatefulWidget {
  var args;
  Function setParentState;
  WaitingRoomPage({Key? key, required this.args, required this.setParentState})
      : super(key: key);

  @override
  State<WaitingRoomPage> createState() => _WaitingRoomPageState();
}

class _WaitingRoomPageState extends State<WaitingRoomPage> {
  RoomUseCase roomUseCase =
      RoomUseCase(RoomRepository(FirebaseFirestore.instance));
  PlayerUseCase playerUseCase =
      PlayerUseCase(PlayerRepository(FirebaseFirestore.instance));

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as WaitingRoomArgs;
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: getPrimaryColor(),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Home icon
              getChildrenWithIcon(
                  context,
                  const Icon(Icons.home),
                  getSecondaryColor(),
                  MaterialPageRoute(builder: (context) => const HomePage())),

              // Main screen
              playerUseCase.onPlayersUpdate(widget.args, widget.setParentState),

              //Chat icon
              widget.args.isHost == true
                  ? Row(
                      children: [
                        getIconButtonStyle(
                            getSecondaryColor(),
                            roundConfig(context, getSecondaryColor(),
                                getPrimaryColor(), widget.args.roomID)),
                        getIconButtonStyle(
                            getSecondaryColor(),
                            openChat(
                                context,
                                getSecondaryColor(),
                                getPrimaryColor(),
                                widget.args.roomID,
                                widget.args.icon)),
                      ],
                    )
                  : getIconButtonStyle(
                      getSecondaryColor(),
                      openChat(context, getSecondaryColor(), getPrimaryColor(),
                          widget.args.roomID, widget.args.icon)),
            ],
          )),
    );
  }
}

// @param names: Player names in order
// @param icons: Player images in order
// @return Container with horizontal list view
Row getIDBanner(String roomID) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      getIconButtonStyle(
        getSecondaryColor(),
        IconButton(
          iconSize: getIconSize(),
          icon: const Icon(Icons.content_copy),
          onPressed: () async {
            await Clipboard.setData(ClipboardData(text: roomID));
          },
        ),
      ),
      Text("   " + roomID,
          style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 2)),
    ],
  );
}

// @param Players: Players to draw
// @return Container with horizontal list view
Container getHorizontalList(List<Player> players) {
  return Container(
      alignment: Alignment.center,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
          players.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 15),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  width: SizeConfig.blockSizeVertical * 17,
                  height: SizeConfig.blockSizeHorizontal * 9,
                  decoration: BoxDecoration(
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                      shape: BoxShape.circle),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        getRoomIcon(players[index].icon),
                        size: SizeConfig.blockSizeVertical * 10,
                      ),
                      Text(players[index].nickname,
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal))
                    ],
                  )),
            ]),
          ),
        ),
      ));
}

// @param Players: Players to draw
// @return Column with 2 horizontal lists
Column getPlayersList(
  List<Player> players,
) {
  List<Player> firstRowPlayers = [];
  List<Player> secondRowPlayers = [];

  int counter = 0;
  for (var element in players) {
    if (counter < 4) {
      firstRowPlayers.add(element);
    } else {
      secondRowPlayers.add(element);
    }
    counter += 1;
  }

  return Column(
    children: [
      SizedBox(
          height: SizeConfig.safeBlockVertical * 20,
          width: SizeConfig.safeBlockHorizontal * 40,
          child: getHorizontalList(firstRowPlayers)),
      SizedBox(
          height: SizeConfig.safeBlockVertical * 20,
          width: SizeConfig.safeBlockHorizontal * 40,
          child: getHorizontalList(
            secondRowPlayers,
          )),
    ],
  );
}

class GameRoomArgs {
  final bool isHost;
  final String roomID;
  final String icon;
  final String playerNickName;
  GameRoomArgs(this.isHost, this.roomID, this.icon, this.playerNickName);
}
