import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/cards/card_model.dart';
import 'package:spot_it_game/domain/players/player.dart';
import 'package:spot_it_game/presentation/core/card_style.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/game/show_card_selection.dart';

//Additional information:
//8 means there can be 8 players in sesion.
//3 means there are 3 more players besides the current user.
//2 means there are 2 more players besides the current user.
//1 means there are 2 more players besides the current user.
List<Widget> getAmountOfCardsMenu(context, List<Player> playerList) {
  Player currentUser =
      playerList.firstWhere(((element) => element.nickname != "Bot"));
  Player userBot =
      playerList.firstWhere(((element) => element.nickname == "Bot"));
  int amountOfPlayers = playerList.length;

  SizedBox currentUserCard =
      getCardStyle(currentUser.nickname, currentUser.displayedCard, 15, 15);

  return ([
    SizedBox(
        width: SizeConfig.blockSizeHorizontal * 2,
        height: SizeConfig.blockSizeHorizontal * 2),
    if (amountOfPlayers == 8) ...[
      getFirstCardsRow(context, currentUserCard, userBot, 3),
      getSecondCardsRow(context, currentUserCard, userBot, 3),
      getThirdCardsRow(context, currentUserCard, userBot, 3),
    ] else if (amountOfPlayers == 7) ...[
      getFirstCardsRow(context, currentUserCard, userBot, 2),
      getSecondCardsRow(context, currentUserCard, userBot, 2),
      getThirdCardsRow(context, currentUserCard, userBot, 3),
    ] else if (amountOfPlayers == 6) ...[
      getFirstCardsRow(context, currentUserCard, userBot, 3),
      getSecondCardsRow(context, currentUserCard, userBot, 1),
      getThirdCardsRow(context, currentUserCard, userBot, 3),
    ] else if (amountOfPlayers == 5) ...[
      getFirstCardsRow(context, currentUserCard, userBot, 2),
      getSecondCardsRow(context, currentUserCard, userBot, 1),
      getThirdCardsRow(context, currentUserCard, userBot, 2),
    ] else if (amountOfPlayers == 4) ...[
      getFirstCardsRow(context, currentUserCard, userBot, 3),
      getSecondCardsRow(context, currentUserCard, userBot, 1),
      getThirdCardsRow(context, currentUserCard, userBot, 1),
    ] else if (amountOfPlayers == 3) ...[
      getFirstCardsRow(context, currentUserCard, userBot, 2),
      getSecondCardsRow(context, currentUserCard, userBot, 1),
      getThirdCardsRow(context, currentUserCard, userBot, 1),
    ] else if (amountOfPlayers == 2) ...[
      getFirstCardsRow(context, currentUserCard, userBot, 1),
      getSecondCardsRow(context, currentUserCard, userBot, 1),
      getThirdCardsRow(context, currentUserCard, userBot, 1),
    ]
  ]);
}

//Additional information:
//3 means there are 3 more players besides the current user.
//2 means there are 2 more players besides the current user.
//1 means there are 2 more players besides the current user.
Row getFirstCardsRow(
    context, SizedBox currentUserCard, Player player, int amountOfPlayers) {
  return (Row(children: [
    if (amountOfPlayers == 1) ...[
      ...getFirstCardsRowInfo(
          context,
          false,
          true,
          false,
          currentUserCard,
          getCardStyle(player.nickname, player.displayedCard, 10, 10),
          getCardStyle(player.nickname, player.displayedCard, 10, 10),
          getCardStyle(player.nickname, player.displayedCard, 10, 10)),
    ] else if (amountOfPlayers == 2) ...[
      ...getFirstCardsRowInfo(
          context,
          true,
          false,
          true,
          currentUserCard,
          getCardStyle(player.nickname, player.displayedCard, 10, 10),
          getCardStyle(player.nickname, player.displayedCard, 10, 10),
          getCardStyle(player.nickname, player.displayedCard, 10, 10)),
    ] else ...[
      ...getFirstCardsRowInfo(
          context,
          true,
          true,
          true,
          currentUserCard,
          getCardStyle(player.nickname, player.displayedCard, 10, 10),
          getCardStyle(player.nickname, player.displayedCard, 10, 10),
          getCardStyle(player.nickname, player.displayedCard, 10, 10)),
    ],
  ]));
}

//Additional information:
//2 means there are 2 more players besides the current user.
//1 means there are 2 more players besides the current user.
Row getSecondCardsRow(
    context, SizedBox currentUserCard, Player player, int amountOfPlayers) {
  return (Row(children: [
    if (amountOfPlayers == 1) ...[
      ...getSecondCardsRowInfo(
          context,
          false,
          false,
          currentUserCard,
          getCardStyle(player.nickname, player.displayedCard, 10, 10),
          getCardStyle(player.nickname, player.displayedCard, 10, 10)),
    ] else if (amountOfPlayers == 2) ...[
      ...getSecondCardsRowInfo(
          context,
          true,
          true,
          currentUserCard,
          getCardStyle(player.nickname, player.displayedCard, 10, 10),
          getCardStyle(player.nickname, player.displayedCard, 10, 10)),
    ] else if (amountOfPlayers == 3) ...[
      ...getSecondCardsRowInfo(
          context,
          true,
          true,
          currentUserCard,
          getCardStyle(player.nickname, player.displayedCard, 10, 10),
          getCardStyle(player.nickname, player.displayedCard, 10, 10)),
    ]
  ]));
}

//Additional information:
//2 means there are 2 more players besides the current user.
//1 means there are 2 more players besides the current user.
Row getThirdCardsRow(
    context, SizedBox currentUserCard, Player player, int amountOfPlayers) {
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
              getCardStyle(player.nickname, player.displayedCard, 10, 10),
              currentUserCard,
              getCardStyle(player.nickname, player.displayedCard, 10, 10)),
        ] else if (amountOfPlayers == 2) ...[
          ...getThirdCardsRowInfo(
              context,
              true,
              true,
              true,
              getCardStyle(player.nickname, player.displayedCard, 10, 10),
              currentUserCard,
              getCardStyle(player.nickname, player.displayedCard, 10, 10)),
        ] else if (amountOfPlayers == 3) ...[
          ...getThirdCardsRowInfo(
              context,
              true,
              true,
              true,
              getCardStyle(player.nickname, player.displayedCard, 10, 10),
              currentUserCard,
              getCardStyle(player.nickname, player.displayedCard, 10, 10)),
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
    context,
    bool stateCardOne,
    bool stateCardTwo,
    bool stateCardThree,
    SizedBox currentUserCard,
    SizedBox cardOne,
    SizedBox cardTwo,
    SizedBox cardThree) {
  return ([
    InkWell(
        child: getVisibilityCard(stateCardOne, cardOne),
        onTap: stateCardOne
            ? () {
                showCardSelection(context, currentUserCard, cardOne);
              }
            : null),
    const Text("  "),
    InkWell(
        child: Padding(
          padding: EdgeInsets.only(bottom: SizeConfig.blockSizeHorizontal * 3),
          child: getVisibilityCard(stateCardTwo, cardTwo),
        ),
        onTap: stateCardTwo
            ? () {
                showCardSelection(context, currentUserCard, cardTwo);
              }
            : null),
    const Text("  "),
    InkWell(
        child: getVisibilityCard(stateCardThree, cardThree),
        onTap: stateCardThree
            ? () {
                showCardSelection(context, currentUserCard, cardThree);
              }
            : null),
  ]);
}

List<Widget> getSecondCardsRowInfo(
    context,
    bool stateCardOne,
    bool stateCardThree,
    SizedBox currentUserCard,
    SizedBox cardOne,
    SizedBox cardThree) {
  return ([
    InkWell(
        child: getVisibilityCard(stateCardOne, cardOne),
        onTap: stateCardOne
            ? () {
                showCardSelection(context, currentUserCard, cardOne);
              }
            : null),
    const Text("          "),
    SizedBox(
      width: SizeConfig.blockSizeHorizontal * 10,
      height: SizeConfig.blockSizeHorizontal * 10,
      child: const Image(
        image: AssetImage('assets/logo.png'),
      ),
    ),
    const Text("           "),
    InkWell(
        child: getVisibilityCard(stateCardThree, cardThree),
        onTap: stateCardThree
            ? () {
                showCardSelection(context, currentUserCard, cardThree);
              }
            : null),
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
      child: InkWell(
          child: getVisibilityCard(stateCardThree, cardThree),
          onTap: stateCardOne
              ? () {
                  showCardSelection(context, cardTwo, cardOne);
                }
              : null),
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("  "),
        getVisibilityCard(stateCardTwo, cardTwo),
      ],
    ),
    Padding(
      padding: EdgeInsets.only(top: SizeConfig.blockSizeHorizontal * 1),
      child: InkWell(
          child: getVisibilityCard(stateCardThree, cardThree),
          onTap: stateCardThree
              ? () {
                  showCardSelection(context, cardTwo, cardThree);
                }
              : null),
    ),
  ]);
}
