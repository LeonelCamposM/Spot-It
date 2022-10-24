// ignore_for_file: unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/application/rooms/rooms_use_case.dart';
import 'package:spot_it_game/infrastructure/rooms/eventListeners/on_joinable_update.dart';
import 'package:spot_it_game/infrastructure/rooms/rooms_repository.dart';
import 'package:spot_it_game/presentation/chat/chat.dart';
import 'package:spot_it_game/presentation/core/focus_box.dart';
import 'package:spot_it_game/presentation/core/get_children_with_icon.dart';
import 'package:spot_it_game/presentation/core/icon_button_style.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/core/text_button_style.dart';
import 'package:spot_it_game/presentation/core/text_style.dart';
import 'package:spot_it_game/presentation/register_room/register_room.dart';
import 'package:spot_it_game/presentation/home/home.dart';
import 'package:flutter/services.dart';
import 'package:spot_it_game/presentation/waiting_room/colors.dart';
import 'dart:math';

class WaitingRoomPage extends StatefulWidget {
  static String routeName = '/waiting_room';
  const WaitingRoomPage({Key? key}) : super(key: key);
  @override
  State<WaitingRoomPage> createState() => _WaitingRoomPageState();
}

class _WaitingRoomPageState extends State<WaitingRoomPage> {
  // Testing data

  List<IconData> icons = [
    Icons.soap,
    Icons.nearby_error,
    Icons.join_left,
    Icons.leaderboard
  ];
  List<String> names = ["Sofia", "Nayeri", "Jeremy", "Leonel"];
  RoomUseCase roomUseCase =
      RoomUseCase(RoomRepository(FirebaseFirestore.instance));

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
    final args = ModalRoute.of(context)!.settings.arguments as WaitingRoomArgs;
    // roomUseCase.onJoinableUpdate(
    //     context, GameRoomArgs(args.isHost, args.roomID));
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
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: getFocusBox(
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Room ID
                        getIDBanner(args.roomID),
                        OnJoinableUpdate(roomID: args.roomID),
                        // Players list view
                        getPlayersList(names, icons),

                        // Start button
                        Center(
                            child: args.isHost == true
                                ? getTextButton(
                                    "COMENZAR",
                                    SizeConfig.safeBlockHorizontal * 20,
                                    SizeConfig.safeBlockVertical * 10,
                                    SizeConfig.safeBlockHorizontal * 2,
                                    getSecondaryColor(), () {
                                    roomUseCase.updateJoinable(args.roomID);
                                  })
                                : getText(
                                    "Esperando al host para comenzar ...",
                                    SizeConfig.safeBlockHorizontal * 1.5,
                                    Alignment.topCenter)),
                      ],
                    ),
                    SizeConfig.safeBlockVertical * 85,
                    SizeConfig.safeBlockHorizontal * 50),
              ),

              //Chat icon
              getIconButtonStyle(
                  getSecondaryColor(),
                  openChat(context, getSecondaryColor(), getPrimaryColor(),
                      args.roomID)),
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

// @param names: Player names in order
// @param icons: Player images in order
// @return Container with horizontal list view
Container getHorizontalList(List<String> names, List<IconData> icons) {
  return Container(
      alignment: Alignment.center,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
          names.length,
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
                        icons[index],
                        size: SizeConfig.blockSizeVertical * 10,
                      ),
                      Text(names[index],
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal))
                    ],
                  )),
            ]),
          ),
        ),
      ));
}

// @param names: Player names in order
// @param icons: Player images in order
// @return Column with 2 horizontal lists
Column getPlayersList(List<String> names, List<IconData> icons) {
  return Column(
    children: [
      SizedBox(
          height: SizeConfig.safeBlockVertical * 20,
          width: SizeConfig.safeBlockHorizontal * 40,
          child: getHorizontalList(names, icons)),
      SizedBox(
          height: SizeConfig.safeBlockVertical * 20,
          width: SizeConfig.safeBlockHorizontal * 40,
          child: getHorizontalList(
            names,
            icons,
          )),
    ],
  );
}

class GameRoomArgs {
  final bool isHost;
  final String roomID;
  GameRoomArgs(this.isHost, this.roomID);
}
