

import 'package:flutter/material.dart';
import 'package:spot_it_game/presentation/core/icon_button_style.dart';

Widget getChildrenWithIcon(BuildContext context, Icon icon, Color secondaryColor,  MaterialPageRoute route){
  return getIconButtonStyle(secondaryColor, 
    IconButton(
      icon: icon,
      iconSize: getIconSize(),
      alignment: Alignment.center,
      onPressed: () {
        Navigator.push(
          context,
          route,
        );
      },
    ),
  );
}