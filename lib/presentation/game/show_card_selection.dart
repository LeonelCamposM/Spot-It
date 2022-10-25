import 'package:flutter/material.dart';
import 'package:spot_it_game/presentation/core/card_style.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/core/text_button_style.dart';
import 'package:spot_it_game/presentation/game/colors.dart';

List<String> cardSelection = [];

Future showCardSelection(context, SizedBox cardOne, SizedBox cardTwo) {
  List<String> cardOneInformation = cardOne.key
      .toString()
      .replaceAll("[<", "")
      .replaceAll(">]", "")
      .replaceAll("'", "")
      .split("%%");
  List<String> cardTwoInformation = cardTwo.key
      .toString()
      .replaceAll("[<", "")
      .replaceAll(">]", "")
      .replaceAll("'", "")
      .split("%%");

  String userNameCardOne = cardOneInformation[0];
  String userNameCardTwo = cardTwoInformation[0];
  List<String> currentUserCard = cardOneInformation[1].split(",");

  List<String> otherUserCard = cardTwoInformation[1].split(",");

  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            backgroundColor: getPrimaryColor(),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            userNameCardOne,
                            style: const TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 25,
                            height: SizeConfig.blockSizeHorizontal * 25,
                            child: getCardStylePopUp(setState, userNameCardOne,
                                currentUserCard, 10, 10),
                          ),
                        ],
                      ),
                      const Text("  "),
                      Column(
                        children: [
                          Text(
                            userNameCardTwo,
                            style: const TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 25,
                            height: SizeConfig.blockSizeHorizontal * 25,
                            child: getCardStylePopUp(setState, userNameCardTwo,
                                otherUserCard, 10, 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 5,
                        height: SizeConfig.blockSizeHorizontal * 5,
                        child: cardSelection.isNotEmpty
                            ? getSingleCardIconPopUp(setState, userNameCardOne,
                                cardSelection[0].split(" ")[1])
                            : const Text(" "),
                      ),
                      const Text("  "),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 5,
                        height: SizeConfig.blockSizeHorizontal * 5,
                        child: cardSelection.length == 2
                            ? getSingleCardIconPopUp(setState, userNameCardTwo,
                                cardSelection[1].split(" ")[1])
                            : const Text(" "),
                      )
                    ],
                  ),
                  const Text("  "),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getTextButton(
                          "SPOT IT!",
                          SizeConfig.safeBlockHorizontal * 20,
                          SizeConfig.safeBlockVertical * 10,
                          SizeConfig.safeBlockHorizontal * 2,
                          getSecondaryColor(),
                          () => {}),
                      const Text("  "),
                      getTextButton(
                          "CANCELAR",
                          SizeConfig.safeBlockHorizontal * 20,
                          SizeConfig.safeBlockVertical * 10,
                          SizeConfig.safeBlockHorizontal * 2,
                          getSecondaryColor(),
                          () => {Navigator.pop(context)})
                    ],
                  ),
                ]),
              ],
            ),
          );
        },
      );
    },
  );
}

SizedBox getCardStylePopUp(Function(void Function()) setState, String userName,
    List<String> card, int width, int height) {
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
              getSingleCardIconPopUp(setState, userName, card[0]),
              getDoubleCardIconPopUp(setState, userName, card[1], card[2]),
              getDoubleCardIconPopUp(setState, userName, card[3], card[4]),
              getDoubleCardIconPopUp(setState, userName, card[5], card[6]),
              getSingleCardIconPopUp(setState, userName, card[7])
            ],
          )));
}

// @return returns a Flexible with 2 rendered icons
// @param card: CardData with all cards icons
// @param iconOne: name of icon to be rendered
// @param showButtonCard: whether to show icons as buttons or no
Flexible getDoubleCardIconPopUp(Function(void Function()) setState,
    String userName, String iconNameOne, String iconNameTwo) {
  return Flexible(
      flex: 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          getSingleCardIconPopUp(setState, userName, iconNameOne),
          getSingleCardIconPopUp(setState, userName, iconNameTwo)
        ],
      ));
}

// @return returns a Flexible with rendered icon
// @param card: CardData with all cards icons
// @param iconName: name of icon to be rendered
// @param showButtonCard: whether to show icons as buttons or no
SizedBox getSingleCardIconPopUp(
    Function(void Function()) setState, userName, String iconName) {

  return SizedBox(
    height: SizeConfig.blockSizeHorizontal * 7,
    width: SizeConfig.blockSizeHorizontal * 7,
    child: ElevatedButton(
      child: Container(
        child: getIcon(iconName),
      ),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        
        primary: Colors.white,
      ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
      onPressed: () => setState(() => {
            if (cardSelection.isEmpty)
              {
                cardSelection.add(userName + " " + iconName),
              }
            else if (cardSelection.length < 2)
              {
                if (cardSelection[0] != userName + " " + iconName)
                  cardSelection.add(userName + " " + iconName),
              }
            else if (cardSelection.length >= 2)
              {
                cardSelection.clear(),
                cardSelection.add(userName + " " + iconName),
              },
          }),
    ),
  );
}
