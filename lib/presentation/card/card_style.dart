import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/Card/card.dart';

Container getCardStyle(CardSpot card) {
  return Container(
      width: 100,
      height: 100,
      margin: const EdgeInsets.all(100.0),
      decoration:
          const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
      child: Column(children: [
        Flexible(flex: 1, child: Icon(card.getIcon(7))),
        Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(card.getIcon(0)),
                Icon(card.getIcon(2)),
              ],
            )),
        Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Icon(card.getIcon(3)), Icon(card.getIcon(4))],
            )),
        Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(card.getIcon(5)),
                Icon(card.getIcon(6)),
              ],
            )),
        Flexible(flex: 1, child: Icon(card.getIcon(1)))
      ]));
}
