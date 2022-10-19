import 'dart:math';
import 'package:flutter/material.dart';
import 'package:spot_it_game/infrastructure/chat/eventListeners/on_chat_update.dart';
import 'package:spot_it_game/presentation/core/focus_box.dart';
import 'package:spot_it_game/presentation/core/icon_button_style.dart';
import 'package:spot_it_game/presentation/core/input_field.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/core/text_style.dart';

IconButton openChat(context, Color secondaryColor, Color primaryColor) {
  // Testing data
  List<IconData> icons = [
    Icons.soap,
    Icons.nearby_error,
    Icons.join_left,
    Icons.leaderboard,
    Icons.soap,
    Icons.nearby_error,
    Icons.join_left,
    Icons.leaderboard
  ];
  List<String> names = [
    "Sofia: estoy muy emocionada por empezar ",
    "Nayeri: les voy a ganar a todos",
    "Jeremy: me voy a poner lolchi",
    "Leonel: el chat me quedó lindo",
    "Sofia: estoy muy emocionada por empezar ",
    "Nayeri: les voy a ganar a todos",
    "Jeremy: me voy a poner lolchi",
    "Leonel: el chat me quedó lindo"
  ];

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
                    child: Row(
                      children: [
                        const Text(""),
                        SizedBox(
                            height: SizeConfig.blockSizeVertical * 85,
                            width: SizeConfig.blockSizeHorizontal * 50,
                            child: OnChatUpdate()),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            getCloseButton(secondaryColor, context),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // user input
                  getMessageBar(secondaryColor, context),
                ],
              ),
            );
          });
    },
    icon: const Icon(Icons.chat),
  );
}

// @param secondaryColor: current page secondary color
// @param context: build context
// @return Row with input text and send button
Row getMessageBar(Color secondaryColor, context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Flexible(
        flex: 8,
        child: Padding(
          padding: const EdgeInsets.only(),
          child: getInputField(" Ingrese un mensaje", context),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: getIconButtonStyle(
            secondaryColor,
            IconButton(
              iconSize: getIconSize(),
              icon: const Icon(Icons.send),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
      ),
    ],
  );
}

// @param secondaryColor: current page secondary color
// @param context: build context
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

// @param messages: Player messages in order
// @param icons: Player images in order
// @return Container with vertical list chat view
ListView getVerticalList(List<String> messages, List<IconData> icons) {
  return ListView(
      scrollDirection: Axis.vertical,
      children: List.generate(
        messages.length,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  width: SizeConfig.blockSizeHorizontal * 5,
                  height: SizeConfig.blockSizeVertical * 10,
                  decoration: BoxDecoration(
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                      shape: BoxShape.circle),
                  child: Icon(
                    icons[index],
                    size: SizeConfig.blockSizeVertical * 5,
                  )),
              const Text("   "),
              getFocusBox(
                  getText(messages[index], SizeConfig.blockSizeHorizontal * 1.5,
                      Alignment.centerLeft),
                  SizeConfig.blockSizeVertical * 10,
                  SizeConfig.blockSizeHorizontal * 43),
            ],
          ),
        ),
      ));
}
