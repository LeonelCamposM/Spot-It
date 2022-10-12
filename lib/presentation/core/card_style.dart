import 'dart:math';
import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/cards/card_model.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';

// @return returns a container with rendered card
// @param card: CardData with all cards icons
// @param size: te size will be assigned to width and height
SizedBox getCardStyle(CardModel card, int width, int height) {
  var cardBackgroundColor = const Color.fromARGB(255, 255, 255, 255);
  var cardBorderColor = Colors.black;

  return SizedBox(
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
              getSingleCardIcon(card, card.iconOne),
              getDoubleCardIcon(card, card.iconTwo, card.iconThree),
              getDoubleCardIcon(card, card.iconFour, card.iconFive),
              getDoubleCardIcon(card, card.iconSix, card.iconSeven),
              getSingleCardIcon(card, card.iconEight)
            ],
          )));
}

// @return returns a Flexible with 2 rendered icons
// @param card: CardData with all cards icons
// @param iconOne: name of icon to be rendered
Flexible getDoubleCardIcon(
    CardModel card, String iconNameOne, String iconNameTwo) {
  return Flexible(
      flex: 1,  
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          getSingleCardIcon(card, iconNameOne),
          getSingleCardIcon(card, iconNameTwo)
        ],
      ));
}

// @return returns a Flexible with rendered icon
// @param card: CardData with all cards icons
// @param iconName: name of icon to be rendered
Flexible getSingleCardIcon(CardModel card, String iconName) {
  double rotation = Random().nextInt(360) / 360;
  return Flexible(
      flex: 1,
      child: RotationTransition(
        turns: AlwaysStoppedAnimation(rotation),
        child: card.getIcon(iconName),
      ));
}
