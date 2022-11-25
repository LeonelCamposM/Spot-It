import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/application/chat/rooms_use_case.dart';
import 'package:spot_it_game/domain/chat/message.dart';
import 'package:spot_it_game/infrastructure/chat/chat_repositoy.dart';
import 'package:spot_it_game/infrastructure/chat/eventListeners/on_chat_update.dart';
import 'package:spot_it_game/presentation/core/focus_box.dart';
import 'package:spot_it_game/presentation/core/icon_button_style.dart';
import 'package:spot_it_game/presentation/core/input_field.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/core/text_style.dart';
import 'package:spot_it_game/presentation/register_room/available_icons.dart';

IconButton openChat(BuildContext context, Color secondaryColor,
    Color primaryColor, String roomID, String icon) {
  // Abstract Interface that provides database services
  final chatUseCase =
      ChatUseCase(ChatRepository(FirebaseFirestore.instance, roomID));

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
                        OnChatUpdate(roomID: roomID),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            getCloseButton(secondaryColor, context),
                          ],
                        ),
                      ],
                    ),
                  ),

                  //user input
                  getMessageBar(secondaryColor, chatUseCase, context, icon),
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
Row getMessageBar(Color secondaryColor, ChatUseCase chatUseCase,
    BuildContext context, String icon) {
  final textController = TextEditingController();
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Flexible(
        flex: 8,
        child: Padding(
          padding: const EdgeInsets.only(),
          child: getInputField("Ingrese un mensaje", textController, context),
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
                if (textController.text != "") {
                  chatUseCase.sendMessage(
                    Message(textController.text,
                        DateTime.now().microsecondsSinceEpoch, icon),
                  );
                  textController.clear();
                }
              },
            )),
      ),
    ],
  );
}

// @param secondaryColor: current page secondary color
// @param context: build context
// @return Row with close button aligned to right
Row getCloseButton(Color secondaryColor, BuildContext context) {
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
Widget getVerticalList(List<Message> messages) {
  return SizedBox(
    height: SizeConfig.blockSizeVertical * 85,
    width: SizeConfig.blockSizeHorizontal * 50,
    child: ListView(
        reverse: true,
        scrollDirection: Axis.vertical,
        children: List.generate(
          messages.length,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Container(
                    width: SizeConfig.blockSizeHorizontal * 5,
                    height: SizeConfig.blockSizeVertical * 10,
                    decoration: BoxDecoration(
                        color: Colors.primaries[
                            Random().nextInt(Colors.primaries.length)],
                        shape: BoxShape.circle),
                    child: Icon(
                      getRoomIcon(messages[index].icon),
                      size: SizeConfig.blockSizeVertical * 5,
                    )),
                const Text("   "),
                FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Row(
                    children: [
                      getFocusBox(
                          getText(
                              messages[index].message,
                              SizeConfig.blockSizeHorizontal * 1.5,
                              Alignment.centerLeft),
                          SizeConfig.blockSizeVertical * 10,
                          SizeConfig.blockSizeHorizontal * 43),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
  );
}
