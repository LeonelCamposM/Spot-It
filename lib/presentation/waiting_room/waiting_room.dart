import 'package:flutter/material.dart';
import 'package:spot_it_game/presentation/chat/chat.dart';
import 'package:spot_it_game/presentation/core/focus_box.dart';
import 'package:spot_it_game/presentation/core/get_children_with_icon.dart';
import 'package:spot_it_game/presentation/core/icon_button_style.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/core/text_button_style.dart';
import 'package:spot_it_game/presentation/game/game.dart';
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
  String roomID = "gMIPh2BsGpaZqIx6EHPj";

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
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: getPrimaryColor(),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
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
                        getIDBanner(roomID),

                        // Players list view
                        getPlayersList(names, icons),

                        // Start button
                        getTextButton(
                            "COMENZAR",
                            SizeConfig.safeBlockHorizontal * 20,
                            SizeConfig.safeBlockVertical * 10,
                            SizeConfig.safeBlockHorizontal * 2,
                            getSecondaryColor(),
                            const GamePage(),
                            context)
                      ],
                    ),
                    SizeConfig.safeBlockVertical * 85,
                    SizeConfig.safeBlockHorizontal * 50),
              ),

              // Chat icon
              getIconButtonStyle(getSecondaryColor(),
                  openChat(context, getSecondaryColor(), getPrimaryColor())),
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
Container getHorizontalList(List<String> names, List<IconData> icons,
    double safeBlockVertical, double safeBlockHorizontal) {
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
                  width: safeBlockVertical * 17,
                  height: safeBlockHorizontal * 9,
                  decoration: BoxDecoration(
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                      shape: BoxShape.circle),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icons[index],
                        size: safeBlockVertical * 10,
                      ),
                      Text(names[index],
                          style: TextStyle(fontSize: safeBlockHorizontal))
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
          child: getHorizontalList(names, icons, SizeConfig.safeBlockVertical,
              SizeConfig.blockSizeHorizontal)),
      SizedBox(
          height: SizeConfig.safeBlockVertical * 20,
          width: SizeConfig.safeBlockHorizontal * 40,
          child: getHorizontalList(names, icons, SizeConfig.safeBlockVertical,
              SizeConfig.blockSizeHorizontal)),
    ],
  );
}
