import 'package:flutter/material.dart';

Map<String, IconData> roomIcons = {
  'soap': Icons.add_shopping_cart,
  'calendar_view_week_rounded': Icons.calendar_view_day_rounded,
  'call_end_outlined': Icons.call_end_outlined,
  'call_made': Icons.call_made,
};

IconData getRoomIcon(String icon) {
  return roomIcons[icon]!;
}
