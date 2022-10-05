import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/cards/card_data.dart';

// @return returns a container with rendered card
// @param card: CardData with all cards icons
// @param size: te size will be assigned to width and height
Container getCardStyle(CardData card, double size) {
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
              Flexible(flex: 1, child: card.getIcon(7)),
              Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(child: card.getIcon(0)),
                      card.getIcon(2),
                    ],
                  )),
              Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [card.getIcon(3), card.getIcon(4)],
                  )),
              Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      card.getIcon(5),
                      card.getIcon(6),
                    ],
                  )),
              Flexible(flex: 1, child: card.getIcon(1))
            ],
          )));
}
