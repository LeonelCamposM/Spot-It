import 'package:flutter/material.dart';

Map<String, IconData> roomIcons = {
  "Face": Icons.face,
  "Heart": Icons.favorite,
  "Skyrocket": Icons.rocket_launch,
  "Moon": Icons.nightlight_round_sharp,
  "Soccer": Icons.sports_soccer,
  "Ladybug": Icons.emoji_nature,
  "Cookie": Icons.cookie,
  "Rabbit": Icons.cruelty_free,
  "Piano": Icons.piano,
  "Stars": Icons.auto_awesome,
  "Paint": Icons.palette,
  "Sun": Icons.wb_sunny,
  "Music": Icons.music_note,
  "Book": Icons.auto_stories,
  "Flower": Icons.filter_vintage,
  "Diamond": Icons.diamond,
};

IconData getRoomIcon(String icon) {
  return roomIcons[icon]!;
}

IconData getRoomIcon2(int position) {
  return roomIcons[position]!;
}
