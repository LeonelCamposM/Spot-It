import 'package:flutter/material.dart';

class CardData {
  List<String> icons = [
    "assets/logo.png",
    "assets/logo.png",
    "assets/logo.png",
    "assets/logo.png",
    "assets/logo.png",
    "assets/logo.png",
    "assets/logo.png",
    "assets/logo.png",
  ];

  CardData(this.icons);

  Image getIcon(int n) {
    return Image.asset(
      // "assets/icons/" + icons[n] + ".png",
      "assets/logo.png",
      scale: 0.3,
      fit: BoxFit.fitWidth,
    );
  }

  factory CardData.fromJson(Map<String, dynamic> json) =>
      CardData(json['icons'] as List<String>);

  Map<String, dynamic> toJson() => {'icons': icons};
}
