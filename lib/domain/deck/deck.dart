import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/cards/card_data.dart';

import '../cards/card_model.dart';

class Deck {

  // List<CardData> cards = [];
  List<CardModel> icons;

  Deck(this.icons);


  factory Deck.fromJson(Map<String, dynamic> json) =>
      Deck(json['icons'] as List<CardModel>);

  Map<String, dynamic> toJson() => {'icons': icons, 'icons': icons};

  // bool buildDeck() {
  //   bool error = false;
  //   return error;
  // }
}
