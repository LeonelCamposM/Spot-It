import 'dart:math';
import 'package:flutter/material.dart';
import 'package:spot_it_game/presentation/core/get_children_with_icon.dart';
import 'package:spot_it_game/presentation/core/icon_button_style.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/core/text_style.dart';
import 'package:spot_it_game/presentation/create_room/colors.dart';
import 'package:spot_it_game/presentation/scoreboard/scoreboard.dart';

IconButton openList(context, Color secondaryColor, Color primaryColor) {
  // Testing data
  List<IconData> icons = [
    Icons.emoji_events,
    Icons.nearby_error,
    Icons.join_left,
    Icons.leaderboard,
    Icons.soap,
    Icons.nearby_error,
    Icons.join_left,
    Icons.leaderboard
  ];
  List<String> names = [
    "Leonel",
    "Sofia",
    "Nayeri",
    "Jeremy",
    "Alicia",
    "Mauricio",
    "Xime",
    "Olman"
  ];
  List<int> score = [30, 20, 10, 9, 7, 5, 3, 2, 0];

  return IconButton(
    iconSize: getIconSize(),
    onPressed: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              backgroundColor: primaryColor,
              content: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // close button
                  Flexible(
                    flex: 4,
                    child: SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(""),
                          const Text("Tabla de posiciones",
                              style: TextStyle(fontSize: 20.0),
                              textAlign: TextAlign.center),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              getCloseButton(secondaryColor, context),
                            ],
                          ),
                        ],
                      ),
                      height: SizeConfig.blockSizeVertical * 20,
                      width: SizeConfig.blockSizeHorizontal * 50,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text("Icono", style: TextStyle(fontSize: 20.0)),
                      Text("Nombre", style: TextStyle(fontSize: 20.0)),
                      Text("Puntaje", style: TextStyle(fontSize: 20.0)),
                    ],
                  ),
                  const Text("", style: TextStyle(fontSize: 20.0)),
                  SizedBox(
                      height: SizeConfig.blockSizeVertical * 65,
                      width: SizeConfig.blockSizeHorizontal * 50,
                      child: getVerticalList(names, icons, score)),
                ],
              ),
            );
          });
    },
    icon: const Icon(Icons.list),
  );
}

// @param secondaryColor: current page secondary color
// @param context: build context
// @return Row with close button aligned to rigth
Row getCloseButton(Color secondaryColor, context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: getIconButtonStyle(
            secondaryColor,
            IconButton(
              iconSize: getIconSize(),
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
      ),
    ],
  );
}

// @param names: Player names in order
// @param icons: Player images in order
// @param score: Player score in order
// @return Container with vertical list of scores
ListView getVerticalList(
    List<String> names, List<IconData> icons, List<int> score) {
  return ListView(
      scrollDirection: Axis.vertical,
      children: List.generate(
        names.length,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  width: SizeConfig.blockSizeHorizontal * 5,
                  height: SizeConfig.blockSizeVertical * 10,
                  decoration: BoxDecoration(
                      color: index != 0
                          ? Colors.primaries[
                              Random().nextInt(Colors.primaries.length)]
                          : Colors.amber,
                      shape: BoxShape.circle),
                  child: Icon(
                    icons[index],
                    size: index != 0
                        ? SizeConfig.blockSizeVertical * 5
                        : SizeConfig.blockSizeVertical * 8,
                  )),
              getText(names[index], SizeConfig.blockSizeHorizontal * 1.5,
                  Alignment.centerLeft),
              getText(score[index].toString(),
                  SizeConfig.blockSizeHorizontal * 1.5, Alignment.centerLeft),
            ],
          ),
        ),
      ));
}
