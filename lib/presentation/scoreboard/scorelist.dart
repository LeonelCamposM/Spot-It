import 'dart:math';
import 'package:flutter/material.dart';
import 'package:spot_it_game/presentation/core/icon_button_style.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/core/text_style.dart';
import 'package:spot_it_game/domain/scoreboard/scoreboard.dart';

IconButton openList(context, List<Scoreboard> scoreboard, List<IconData> icons,
    Color secondaryColor, Color primaryColor) {
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
                children: [
                  // close button
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(""),
                        Text("Tabla de posiciones",
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 2),
                            textAlign: TextAlign.center),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            getCloseButton(secondaryColor, context),
                          ],
                        ),
                      ],
                    ),
                    height: SizeConfig.blockSizeVertical * 16,
                    width: SizeConfig.blockSizeHorizontal * 50,
                  ),
                  SizedBox(
                      height: SizeConfig.blockSizeVertical * 70,
                      width: SizeConfig.blockSizeHorizontal * 50,
                      child: getVerticalScoreList(scoreboard, icons)),
                ],
              ),
            );
          });
    },
    icon: const Icon(Icons.list),
  );
}

// @param secondaryColor: Current page secondary color
// @param context: Build context
// @return Row with close button aligned to right
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

// @param scoreboard: scoreboard of the players
// @param icons: Player images in order
// @return Container with vertical list of scores
ListView getVerticalScoreList(
    List<Scoreboard> scoreboard, List<IconData> icons) {
  return ListView(
      scrollDirection: Axis.vertical,
      children: List.generate(
        scoreboard.length,
        (index) => Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  child: index != 0
                      ? Icon(
                          icons[index],
                          size: SizeConfig.blockSizeVertical * 5,
                        )
                      : Icon(
                          Icons.emoji_events,
                          size: SizeConfig.blockSizeVertical * 8,
                        )),
              getText(scoreboard[index].nickname,
                  SizeConfig.blockSizeHorizontal * 1.5, Alignment.centerLeft),
              getText(scoreboard[index].score.toString(),
                  SizeConfig.blockSizeHorizontal * 1.5, Alignment.centerLeft),
            ],
          ),
        ),
      ));
}
