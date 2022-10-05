import 'package:flutter/material.dart';

class CardModel {
  String iconOne;
  String iconTwo;
  String iconThree;
  String iconFour;
  String iconFive;
  String iconSix;
  String iconSeven;
  String iconEight;

  CardModel(this.iconOne, this.iconTwo, this.iconThree, this.iconFour,
      this.iconFive, this.iconSix, this.iconSeven, this.iconEight);

  Image getIcon(String iconName) {
    return Image.asset(
      "assets/icons/" + iconName + ".png",
      scale: 0.3,
      fit: BoxFit.fitWidth,
    );
  }

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        json['iconOne'] as String,
        json['iconTwo'] as String,
        json['iconThree'] as String,
        json['iconFour'] as String,
        json['iconFive'] as String,
        json['iconSix'] as String,
        json['iconSeven'] as String,
        json['iconEight'] as String,
      );

  Map<String, dynamic> toJson() => {
        'iconOne': iconOne,
        'iconTwo': iconTwo,
        'iconThree': iconThree,
        'iconFour': iconFour,
        'iconFive': iconFive,
        'iconSix': iconSix,
        'iconSeven': iconSeven,
        'iconEight': iconEight
      };
}
