import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/cards/card_data.dart';
import 'package:spot_it_game/domain/cards/card_model.dart';

// @return returns a container with rendered card
// @param card: CardData with all cards icons
// @param size: te size will be assigned to width and height
Container getCardStyle(CardModel card, double size) {
  var cardBackgroundColor = Color.fromARGB(255, 164, 65, 65);
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
              Flexible(flex: 1, child: Text(card.iconOne)),
              Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(child: Text(card.iconTwo)),
                      Text(card.iconEight),
                    ],
                  )),
              Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [Text(card.iconFour), Text(card.iconThree)],
                  )),
              Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(card.iconFive),
                      Text(card.iconSix),
                    ],
                  )),
              Flexible(flex: 1, child: Text(card.iconSeven))
            ],
          )));
}
