import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/cards/card_model.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/game/colors.dart';

// @return returns a container with rendered card
// @param card: CardData with all cards icons
// @param size: te size will be assigned to width and height
SizedBox getCardStyle(String userName,
    CardModel card, int width, int height) {
  var cardBackgroundColor = const Color.fromARGB(255, 255, 255, 255);
  var cardBorderColor = Colors.black;
  return SizedBox(
      key: Key(userName + "%%" + jsonEncode(card)),
      width: SizeConfig.safeBlockHorizontal * width,
      height: SizeConfig.safeBlockHorizontal * height,
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: cardBorderColor,
                width: 3,
              ),
              color: cardBackgroundColor,
              shape: BoxShape.circle),
          child: Column(
            children: [
              getSingleCardIcon(card.iconOne),
              getDoubleCardIcon(card.iconTwo, card.iconThree),
              getDoubleCardIcon(card.iconFour, card.iconFive),
              getDoubleCardIcon(card.iconSix, card.iconSeven),
              getSingleCardIcon(card.iconEight)
            ],
          )));
}

// @return returns a Flexible with 2 rendered icons
// @param card: CardData with all cards icons
// @param iconOne: name of icon to be rendered
Flexible getDoubleCardIcon(
    String iconNameOne, String iconNameTwo) {
  return Flexible(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          getSingleCardIcon(iconNameOne),
          getSingleCardIcon(iconNameTwo)
        ],
      ));
}

// @return returns a Flexible with rendered icon
// @param card: CardData with all cards icons
// @param iconName: name of icon to be rendered
Flexible getSingleCardIcon(String iconName) {
  double rotation = Random().nextInt(360) / 360;
  return Flexible(
      flex: 1,
      child: RotationTransition(
        turns: AlwaysStoppedAnimation(rotation),
        //child: card.getIcon(iconName),
        child: ElevatedButton(
          child: Container(
            child: getIcon(iconName),
          ),
          onPressed: null,
          style: ButtonStyle(
              shape: MaterialStateProperty.all(const CircleBorder()),
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                // If the button is pressed, return green, otherwise blue
                if (states.contains(MaterialState.pressed)) {
                  return getSecondaryColor();
                }
                return Colors.white;
              })).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
        ),
      ));
}

Image getIcon(String iconName) {
  return Image.asset(
    "assets/icons/" + iconName + ".png",
    fit: BoxFit.fitWidth,
  );
}
