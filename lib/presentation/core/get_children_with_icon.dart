import 'package:flutter/material.dart';
import 'package:spot_it_game/presentation/core/icon_button_style.dart';

// @param context: build context
// @param icon: button's icon
// @param secondaryColor: button's color
// @param route: route to which the button redirects
// @return button with the choosen icon, color and route
Widget getChildrenWithIcon(BuildContext context, Icon icon,
    Color secondaryColor, MaterialPageRoute route) {
  return getIconButtonStyle(
    secondaryColor,
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
