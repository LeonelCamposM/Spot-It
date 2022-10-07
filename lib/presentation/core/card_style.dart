import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/cards/card_model.dart';

// @return returns a container with rendered card
// @param card: CardData with all cards icons
// @param size: te size will be assigned to width and height
Container getCardStyle(CardModel card, double size) {
  var cardBackgroundColor = const Color.fromARGB(255, 255, 255, 255);
  var cardBorderColor = Colors.black;

  return Container(
      width: size,
      height: size,
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
              Flexible(flex: 1, child: card.getIcon(card.iconOne)),
              Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(child: card.getIcon(card.iconTwo)),
                      card.getIcon(card.iconEight),
                    ],
                  )),
              Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      card.getIcon(card.iconThree),
                      card.getIcon(card.iconFour)
                    ],
                  )),
              Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      card.getIcon(card.iconFive),
                      card.getIcon(card.iconSix),
                    ],
                  )),
              Flexible(flex: 1, child: card.getIcon(card.iconSeven))
            ],
          )));
}
