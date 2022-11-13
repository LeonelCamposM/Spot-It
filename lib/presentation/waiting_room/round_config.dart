import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:spot_it_game/application/chat/rooms_use_case.dart';
import 'package:spot_it_game/infrastructure/chat/chat_repositoy.dart';
import 'package:spot_it_game/presentation/core/icon_button_style.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/core/text_style.dart';

import '../core/text_button_style.dart';

IconButton roundConfig(BuildContext context, Color secondaryColor,
    Color primaryColor, String roomID) {
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            getVerticalList(
                                primaryColor, secondaryColor, context),
                          ],
                        ),
                        getCloseButton(secondaryColor, context),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
    },
    icon: const Icon(Icons.tune),
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

Widget getVerticalList(
    Color primaryColor, Color secondaryColor, BuildContext context) {
  int roundCount = 0;
  return SizedBox(
    height: SizeConfig.blockSizeVertical * 90,
    width: SizeConfig.blockSizeHorizontal * 45,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getText("Configuración de sala", SizeConfig.blockSizeHorizontal * 2,
            Alignment.center),
        Column(
          children: [
            getText("Elegir número de rondas: ",
                SizeConfig.blockSizeHorizontal * 2, Alignment.center),
            CustomNumberPicker(
              valueTextStyle:
                  TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 2),
              customAddButton: const Icon(Icons.expand_less),
              customMinusButton: const Icon(Icons.expand_more),
              shape: const Border(),
              initialValue: 4,
              maxValue: 10,
              minValue: 1,
              step: 1,
              onValue: (value) {
                roundCount = value as int;
              },
            ),
          ],
        ),
        getTextButton(
            "ACEPTAR",
            SizeConfig.safeBlockHorizontal * 15,
            SizeConfig.safeBlockVertical * 10,
            SizeConfig.safeBlockHorizontal * 2,
            secondaryColor, () {
          // funcion para actualizar y pop
          print(roundCount);
          Navigator.pop(context);
        })
      ],
    ),
  );
}
