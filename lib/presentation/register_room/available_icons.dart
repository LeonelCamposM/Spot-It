import 'package:flutter/material.dart';

Map<String, IconData> roomIcons = {
  "0": Icons.adb,
  "1": Icons.face,
  "2": Icons.favorite,
  "3": Icons.rocket_launch,
  "4": Icons.nightlight_round_sharp,
  "5": Icons.sports_soccer,
  "6": Icons.emoji_nature,
  "7": Icons.cookie,
  "8": Icons.cruelty_free,
  "9": Icons.piano,
  "10": Icons.auto_awesome,
  "11": Icons.palette,
  "12": Icons.wb_sunny,
  "13": Icons.music_note,
  "14": Icons.auto_stories,
  "15": Icons.filter_vintage,
  "16": Icons.diamond,
};

IconData getRoomIcon(String icon) {
  return roomIcons[icon]!;
}

IconData getRoomIcon2(int position) {
  return roomIcons[position]!;
}
