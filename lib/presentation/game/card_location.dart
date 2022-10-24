import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/cards/card_model.dart';
import 'package:spot_it_game/presentation/core/card_style.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/game/colors.dart';
import 'package:spot_it_game/presentation/game/show_card_selection.dart';

//Additional information:
//8 means there can be 8 players in sesion.
//3 means there are 3 more players besides the current user.
//2 means there are 2 more players besides the current user.
//1 means there are 2 more players besides the current user.
List<Widget> getAmountOfCardsMenu(
    context, Iterable<CardModel> deckData, int amountOfPlayers) {
  return ([
    SizedBox(
        width: SizeConfig.blockSizeHorizontal * 2,
        height: SizeConfig.blockSizeHorizontal * 2),
    if (amountOfPlayers == 8) ...[
      getFirstCardsRow(deckData, 3),
      getSecondCardsRow(deckData, 2),
      getThirdCardsRow(context, deckData, 2),
    ] else if (amountOfPlayers == 7) ...[
      getFirstCardsRow(deckData, 2),
      getSecondCardsRow(deckData, 2),
      getThirdCardsRow(context, deckData, 2),
    ] else if (amountOfPlayers == 6) ...[
      getFirstCardsRow(deckData, 3),
      getSecondCardsRow(deckData, 1),
      getThirdCardsRow(context, deckData, 2),
    ] else if (amountOfPlayers == 5) ...[
      getFirstCardsRow(deckData, 2),
      getSecondCardsRow(deckData, 1),
      getThirdCardsRow(context, deckData, 2),
    ] else if (amountOfPlayers == 4) ...[
      getFirstCardsRow(deckData, 3),
      getSecondCardsRow(deckData, 1),
      getThirdCardsRow(context, deckData, 1),
    ] else if (amountOfPlayers == 3) ...[
      getFirstCardsRow(deckData, 2),
      getSecondCardsRow(deckData, 1),
      getThirdCardsRow(context, deckData, 1),
    ] else if (amountOfPlayers == 2) ...[
      getFirstCardsRow(deckData, 1),
      getSecondCardsRow(deckData, 1),
      getThirdCardsRow(context, deckData, 1),
    ]
  ]);
}

//Additional information:
//3 means there are 3 more players besides the current user.
//2 means there are 2 more players besides the current user.
//1 means there are 2 more players besides the current user.
Row getFirstCardsRow(deckData, int amountOfPlayers) {
  return (Row(children: [
    if (amountOfPlayers == 1) ...[
      ...getFirstCardsRowInfo(
          false,
          true,
          false,
          getCardStyle(deckData.elementAt(0), 10, 10),
          getCardStyle(deckData.elementAt(0), 10, 10),
          getCardStyle(deckData.elementAt(0), 10, 10)),
    ] else if (amountOfPlayers == 2) ...[
      ...getFirstCardsRowInfo(
          true,
          false,
          true,
          getCardStyle(deckData.elementAt(0), 10, 10),
          getCardStyle(deckData.elementAt(0), 10, 10),
          getCardStyle(deckData.elementAt(0), 10, 10)),
    ] else ...[
      ...getFirstCardsRowInfo(
          true,
          true,
          true,
          getCardStyle(deckData.elementAt(0), 10, 10),
          getCardStyle(deckData.elementAt(0), 10, 10),
          getCardStyle(deckData.elementAt(0), 10, 10)),
    ],
  ]));
}

//Additional information:
//2 means there are 2 more players besides the current user.
//1 means there are 2 more players besides the current user.
Row getSecondCardsRow(deckData, int amountOfPlayers) {
  return (Row(children: [
    if (amountOfPlayers == 1) ...[
      ...getSecondCardsRowInfo(
          false,
          false,
          getCardStyle(deckData.elementAt(0), 10, 10),
          getCardStyle(deckData.elementAt(0), 10, 10)),
    ] else if (amountOfPlayers == 2) ...[
      ...getSecondCardsRowInfo(
          true,
          true,
          getCardStyle(deckData.elementAt(0), 10, 10),
          getCardStyle(deckData.elementAt(0), 10, 10)),
    ]
  ]));
}

//Additional information:
//2 means there are 2 more players besides the current user.
//1 means there are 2 more players besides the current user.
Row getThirdCardsRow(context, deckData, int amountOfPlayers) {
  return (Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (amountOfPlayers == 1) ...[
          ...getThirdCardsRowInfo(
              context,
              false,
              true,
              false,
              getCardStyle(deckData.elementAt(0), 10, 10),
              getCardStyle(deckData.elementAt(0), 15, 15),
              getCardStyle(deckData.elementAt(0), 10, 10)),
        ] else if (amountOfPlayers == 2) ...[
          ...getThirdCardsRowInfo(
              context,
              true,
              true,
              true,
              getCardStyle(deckData.elementAt(0), 10, 10),
              getCardStyle(deckData.elementAt(0), 15, 15),
              getCardStyle(deckData.elementAt(0), 10, 10)),
        ]
      ]));
}

Visibility getVisibilityCard(state, card) {
  return (Visibility(
    visible: state,
    child: card,
    replacement: SizedBox(
      width: SizeConfig.safeBlockHorizontal * 10,
      height: SizeConfig.safeBlockHorizontal * 10,
    ),
  ));
}

List<Widget> getFirstCardsRowInfo(
    bool stateCardOne,
    bool stateCardTwo,
    bool stateCardThree,
    SizedBox cardOne,
    SizedBox cardTwo,
    SizedBox cardThree) {
  return ([
    getVisibilityCard(stateCardOne, cardOne),
    const Text("  "),
    Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.blockSizeHorizontal * 3),
      child: getVisibilityCard(stateCardTwo, cardTwo),
    ),
    const Text("  "),
    getVisibilityCard(stateCardThree, cardThree),
  ]);
}

List<Widget> getSecondCardsRowInfo(bool stateCardOne, bool stateCardThree,
    SizedBox cardOne, SizedBox cardThree) {
  return ([
    getVisibilityCard(stateCardOne, cardOne),
    const Text("          "),
    SizedBox(
      width: SizeConfig.blockSizeHorizontal * 10,
      height: SizeConfig.blockSizeHorizontal * 10,
      child: const Image(
        image: AssetImage('assets/logo.png'),
      ),
    ),
    const Text("           "),
    getVisibilityCard(stateCardThree, cardThree),
  ]);
}

List<Widget> getThirdCardsRowInfo(
    context,
    bool stateCardOne,
    bool stateCardTwo,
    bool stateCardThree,
    SizedBox cardOne,
    SizedBox cardTwo,
    SizedBox cardThree) {
  return ([
    Padding(
      padding: EdgeInsets.only(top: SizeConfig.blockSizeHorizontal * 1),
      child: getVisibilityCard(stateCardOne, cardOne),
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("  "),
        InkWell(
          child: getVisibilityCard(stateCardTwo, cardTwo),
          onTap: () {
            showCardSelection(context, getSecondaryColor(), getPrimaryColor(),
                cardOne, cardOne);
          },
        ),
      ],
    ),
    Padding(
      padding: EdgeInsets.only(top: SizeConfig.blockSizeHorizontal * 1),
      child: getVisibilityCard(stateCardThree, cardThree),
    ),
  ]);
}
