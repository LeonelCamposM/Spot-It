import 'package:flutter/material.dart';
import 'package:spot_it_game/presentation/chat/chat.dart';
import 'package:spot_it_game/presentation/core/button_style.dart';
import 'package:spot_it_game/presentation/core/focus_box.dart';
import 'package:spot_it_game/presentation/core/icon_button_style.dart';
import 'package:spot_it_game/presentation/core/text_style.dart';
import 'package:spot_it_game/presentation/game/game.dart';
import 'package:spot_it_game/presentation/home/home.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import 'package:spot_it_game/presentation/waiting_room/colors.dart';

class WaitingRoomPage extends StatefulWidget {
  static String routeName = '/waiting_room';
  const WaitingRoomPage({Key? key}) : super(key: key);
  @override
  State<WaitingRoomPage> createState() => _WaitingRoomPageState();
}

class _WaitingRoomPageState extends State<WaitingRoomPage> {
  _WaitingRoomPageState() : isLoading = true;

  bool isLoading;
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
    addRoom();
  }

  Future<void> addRoom() async {
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getPrimaryColor(),
      appBar: AppBar(
        backgroundColor: getSecondaryColor(),
        title: const Text('Sala de espera'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Flexible(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getIconButtonStyle(
                    getSecondaryColor(),
                    IconButton(
                      iconSize: getIconSize(),
                      icon: const Icon(Icons.home),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        );
                      },
                    ),
                  ),
                  getIconButtonStyle(
                      getSecondaryColor(),
                      openChat(
                          context, getSecondaryColor(), getPrimaryColor())),
                ],
              ),
            ),
            getFocusBox(
              Column(
                children: [
                  Flexible(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: getIconButtonStyle(
                            getSecondaryColor(),
                            IconButton(
                              iconSize: getIconSize(),
                              icon: const Icon(Icons.content_copy),
                              onPressed: () async {
                                await Clipboard.setData(
                                    ClipboardData(text: roomID));
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text("   " + roomID,
                              style: const TextStyle(fontSize: 20.0)),
                        ),
                      ],
                    ),
                  ),
                  const Text("", style: TextStyle(fontSize: 40.0)),
                  Flexible(
                    flex: 4,
                    child: SizedBox(
                        height: 150,
                        width: 850,
                        child: _horizontalList(4, names, icons)),
                  ),
                  Flexible(
                      flex: 4,
                      child: SizedBox(
                          height: 150,
                          width: 850,
                          child: _horizontalList(4, names, icons))),
                  const Text("", style: TextStyle(fontSize: 40.0)),
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: getButtonStyle(
                                200, 60, 20.0, getSecondaryColor()),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const GamePage()),
                              );
                            },
                            child: getText("COMENZAR", 25, Alignment.center),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              500,
              900,
            ),
          ],
        ),
      ),
    );
  }
}

Container _horizontalList(int n, List<String> names, List<IconData> icons) {
  return Container(
    alignment: Alignment.center,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: List.generate(
        n,
        (i) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 200,
            height: 200,
            alignment: Alignment.center,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                      shape: BoxShape.circle),
                  child: Icon(
                    icons[i],
                    size: 50,
                  )),
              Text(names[i], style: const TextStyle(fontSize: 20.0))
            ]),
          ),
        ),
      ),
    ),
  );
}
