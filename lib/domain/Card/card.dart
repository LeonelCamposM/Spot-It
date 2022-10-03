import 'package:flutter/material.dart';

class CardSpot {
  List<IconData> icons = [
    Icons.soap,
    Icons.nearby_error,
    Icons.join_left,
    Icons.leaderboard,
    Icons.face,
    Icons.h_mobiledata,
    Icons.yard,
    Icons.label
  ];

  IconData getIcon(int n) {
    return icons[n];
  }
}
