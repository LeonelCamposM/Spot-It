import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spot_it_game/presentation/core/icon_button_style.dart';
import 'package:spot_it_game/presentation/core/input_field.dart';
import 'package:spot_it_game/presentation/waiting_room/colors.dart';

IconButton openChat(context, Color secondaryColor, Color primaryColor) {
  List<IconData> icons = [
    Icons.soap,
    Icons.nearby_error,
    Icons.join_left,
    Icons.leaderboard
  ];
  List<String> names = ["Sofia", "Nayeri", "Jeremy", "Leonel"];
  return IconButton(
    iconSize: getIconSize(),
    onPressed: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                contentPadding: const EdgeInsets.only(top: 10.0),
                backgroundColor: primaryColor,
                // ignore: prefer_const_literals_to_create_immutables
                content: Stack(children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ignore: prefer_const_constructors
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          getIconButtonStyle(
                              secondaryColor,
                              IconButton(
                                iconSize: 30.0,
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      Flexible(
                        flex: 4,
                        child: SizedBox(
                            height: 850,
                            width: 850,
                            child: _verticalList(4, names, icons)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(
                            width: 20,
                            height: 20,
                          ),
                          Flexible(
                            flex: 8,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child:
                                  getInputField(" Ingrese un mensaje", context),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: getIconButtonStyle(
                                  secondaryColor,
                                  IconButton(
                                    iconSize: 30.0,
                                    icon: const Icon(Icons.send),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                            height: 20,
                          )
                        ],
                      ),
                    ],
                  ),
                ]));
          });
    },
    icon: const Icon(Icons.chat),
  );
}

Container _verticalList(int n, List<String> names, List<IconData> icons) {
  return Container(
    alignment: Alignment.center,
    child: ListView(
      scrollDirection: Axis.vertical,
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
