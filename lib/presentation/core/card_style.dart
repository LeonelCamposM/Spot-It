import 'dart:math';
import 'package:flutter/material.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/game/colors.dart';

// @return returns a container with rendered card
// @param card: CardData with all cards icons
// @param size: te size will be assigned to width and height
SizedBox getCardStyle(String userName, String card, int width, int height) {
  var cardBackgroundColor = const Color.fromARGB(255, 255, 255, 255);
  var cardBorderColor = Colors.black;
  List<String> iconsCard = card.split(",");
  return SizedBox(
      key: Key(userName + "%%" + card),
      width: SizeConfig.safeBlockHorizontal * width,
      height: SizeConfig.safeBlockHorizontal * height,
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: cardBorderColor,
                width: 3,
              ),
              color: cardBackgroundColor,
              shape: BoxShape.circle),
          child: Column(
            children: [
              getSingleCardIcon(iconsCard[0]),
              getDoubleCardIcon(iconsCard[1], iconsCard[2]),
              getDoubleCardIcon(iconsCard[3], iconsCard[4]),
              getDoubleCardIcon(iconsCard[5], iconsCard[6]),
              getSingleCardIcon(iconsCard[7])
            ],
          )));
}

// @return returns a Flexible with 2 rendered icons
// @param card: CardData with all cards icons
// @param iconOne: name of icon to be rendered
Flexible getDoubleCardIcon(String iconNameOne, String iconNameTwo) {
  return Flexible(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          getSingleCardIcon(iconNameOne),
          getSingleCardIcon(iconNameTwo)
        ],
      ));
}

// @return returns a Flexible with rendered icon
// @param card: CardData with all cards icons
// @param iconName: name of icon to be rendered
Flexible getSingleCardIcon(String iconName) {
  double rotation = Random().nextInt(360) / 360;
  return Flexible(
      flex: 1,
      child: RotationTransition(
        turns: AlwaysStoppedAnimation(rotation),
        child: ElevatedButton(
          child: Container(
            child: getIcon(iconName),
          ),
          onPressed: null,
          style: ButtonStyle(
              shape: MaterialStateProperty.all(const CircleBorder()),
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.pressed)) {
                  return getSecondaryColor();
                }
                return Colors.white;
              })).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
        ),
      ));
}

Image getIcon(String iconName) {
  return Image.asset(
    "assets/icons/" + iconName + ".png",
    fit: BoxFit.fitWidth,
  );
}

// @return returns a SizedBox with render card
// @param setState: setState of widget
// @param cardSelection: the icon selection of the users in game
// @param userName: user name of the current player
// @param card: card of user
// @param width: width of sized box
// @param height: height of sized box
SizedBox getCardStylePopUp(Function setState, List<String> iconSelection,
    String userName, List<String> card, int width, int height) {
  var cardBackgroundColor = const Color.fromARGB(255, 255, 255, 255);
  var cardBorderColor = Colors.black;
  return SizedBox(
      width: SizeConfig.safeBlockHorizontal * width,
      height: SizeConfig.safeBlockHorizontal * height,
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: cardBorderColor,
                width: 3,
              ),
              color: cardBackgroundColor,
              shape: BoxShape.circle),
          child: Column(
            children: [
              getSingleCardIconPopUp(
                  setState, iconSelection, userName, card[0]),
              getDoubleCardIconPopUp(
                  setState, iconSelection, userName, card[1], card[2]),
              getDoubleCardIconPopUp(
                  setState, iconSelection, userName, card[3], card[4]),
              getDoubleCardIconPopUp(
                  setState, iconSelection, userName, card[5], card[6]),
              getSingleCardIconPopUp(setState, iconSelection, userName, card[7])
            ],
          )));
}

// @return returns a Flexible with 2 rendered icons
// @param setState: setState of widget
// @param cardSelection: the icon selection of the users in game
// @param userName: user name of the current player
// @param iconNameOne: first icon selected by current user
// @param iconNameTwo: second icon selected by current user
Flexible getDoubleCardIconPopUp(setState, List<String> iconSelection,
    String userName, String iconNameOne, String iconNameTwo) {
  return Flexible(
      flex: 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          getSingleCardIconPopUp(
              setState, iconSelection, userName, iconNameOne),
          getSingleCardIconPopUp(setState, iconSelection, userName, iconNameTwo)
        ],
      ));
}

// @return returns a SizedBox with rendered icon
// @param setState: setState of widget
// @param cardSelection: the icon selection of the users in game
// @param userName: user name of the current player
// @param iconName: icon of the current user
SizedBox getSingleCardIconPopUp(
    setState, List<String> iconSelection, userName, String iconName) {
  return SizedBox(
    height: SizeConfig.blockSizeHorizontal * 7,
    width: SizeConfig.blockSizeHorizontal * 7,
    child: ElevatedButton(
      child: Container(
        child: getIcon(iconName),
      ),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        // ignore: deprecated_member_use
        primary: Colors.white,
      ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
      onPressed: () => (() => {
            if (iconSelection.isEmpty)
              {setState.call(userName + "%%" + iconName)}
            else if (iconSelection.length < 2)
              {
                if (!iconSelection[0].contains(userName) &&
                    iconSelection[0] != userName + "%%" + iconName)
                  setState.call("one", userName + "%%" + iconName),
              }
            else if (iconSelection.length >= 2)
              {
                iconSelection.clear(),
                setState.call("one", userName + "%%" + iconName),
              },
          }),
    ),
  );
}
