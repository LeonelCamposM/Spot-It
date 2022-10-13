import 'dart:math';
import 'package:flutter/material.dart';
import 'package:spot_it_game/presentation/core/focus_box.dart';
import 'package:spot_it_game/presentation/core/icon_button_style.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/core/text_style.dart';
import 'package:spot_it_game/presentation/home/colors.dart';

IconButton openCredits(context, Color secondaryColor, Color primaryColor) {
  // Testing data
  List<IconData> icons = [
    Icons.face,
    Icons.face,
    Icons.face,
    Icons.face,
  ];
  List<String> names = [
    "Angie Sofia Castillo Campos ",
    "Nayeri Azofeifa Porras",
    "Jeremy Vargas Artavia",
    "Leonel Campos Murillo",
  ];
  List<String> images = [
    "assets/logo.png",
  ];
  List<String> links = ["Icono: https://www.dobblegame.com/es/inicio/"];
  List<IconData> temporal = [
    Icons.front_hand,
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(""),
                      getText("Creadores", SizeConfig.blockSizeHorizontal * 2,
                          Alignment.center),
                      // close button
                      getCloseButton(secondaryColor, context),
                    ],
                  ),
                  Flexible(
                    flex: 5,
                    child: Row(
                      children: [
                        SizedBox(
                            height: SizeConfig.blockSizeVertical * 85,
                            width: SizeConfig.blockSizeHorizontal * 50,
                            child: getVerticalList(names, icons)),
                      ],
                    ),
                  ),
                  getText("Referencias", SizeConfig.blockSizeHorizontal * 2,
                      Alignment.center),
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        SizedBox(
                            height: SizeConfig.blockSizeVertical * 85,
                            width: SizeConfig.blockSizeHorizontal * 50,
                            child: getVerticalList(links, temporal)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
    },
    icon: const Icon(Icons.receipt),
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

// @param text: references or creators' names
// @param icons: icons for creators
// @return Container with vertical list references
ListView getVerticalList(List<String> text, List<IconData> icons) {
  return ListView(
      scrollDirection: Axis.vertical,
      children: List.generate(
        text.length,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  width: SizeConfig.blockSizeHorizontal * 5,
                  height: SizeConfig.blockSizeVertical * 10,
                  decoration: BoxDecoration(
                      color: getSecondaryColor(), shape: BoxShape.circle),
                  child: Icon(
                    icons[index],
                    size: SizeConfig.blockSizeVertical * 5,
                  )),
              const Text("   "),
              getFocusBox(
                  getText(text[index], SizeConfig.blockSizeHorizontal * 1.5,
                      Alignment.centerLeft),
                  SizeConfig.blockSizeVertical * 10,
                  SizeConfig.blockSizeHorizontal * 43),
            ],
          ),
        ),
      ));
}
