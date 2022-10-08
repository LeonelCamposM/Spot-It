import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spot_it_game/application/cards/deck_use_case.dart';
import 'package:spot_it_game/domain/cards/card_model.dart';
import 'package:spot_it_game/domain/deck/deck.dart';
import 'package:spot_it_game/infrastructure/cards/card_repository.dart';
import 'package:spot_it_game/presentation/chat/chat.dart';
import 'package:spot_it_game/presentation/core/card_style.dart';
import 'package:spot_it_game/presentation/core/icon_button_style.dart';
import 'package:spot_it_game/presentation/core/text_style.dart';
import 'package:spot_it_game/presentation/game/colors.dart';
import 'package:spot_it_game/presentation/home/home.dart';

class GamePage extends StatefulWidget {
  static String routeName = '/game';
  const GamePage({Key? key}) : super(key: key);
  @override
  State<GamePage> createState() => _GamePagePageState();
}

class _GamePagePageState extends State<GamePage> {
  CardUseCase cardUseCase =
      CardUseCase(CardRepository(FirebaseFirestore.instance));
  _GamePagePageState() : isLoading = true;
  bool isLoading;
  Iterable<CardModel> deckData = [];

  @override
  void initState() {
    super.initState();
    getDeck();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  Future<void> getDeck() async {
    final deckModel = await cardUseCase.getDeck();
    setState(() {
      deckData = deckModel;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getPrimaryColor(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: getGameScreenWidget(context, deckData),
        ),
      ),
    );
  }
}

Container getLeaderboard() {
  return Container(
    width: 200,
    height: 200,
    decoration: const BoxDecoration(
      color: Color.fromARGB(100, 109, 31, 138),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        getText("Posición", 18, Alignment.topCenter),
        getText("1. Leo", 16, Alignment.topLeft),
        getText("2. Jere", 16, Alignment.topLeft),
        getText("3. Naye", 16, Alignment.topLeft),
      ],
    ),
  );
}

Widget getChildrenWithIcon(
    BuildContext context, Icon icon, MaterialPageRoute route) {
  return getIconButtonStyle(
    getSecondaryColor(),
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

List<Widget> getGameScreenWidget(
    BuildContext context, Iterable<CardModel> deck) {
  return ([
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getChildrenWithIcon(context, const Icon(Icons.home),
            MaterialPageRoute(builder: (context) => const HomePage())),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: getChildrenWithIcon(
                  context,
                  const Icon(Icons.question_mark_rounded),
                  MaterialPageRoute(builder: (context) => const HomePage())),
            ),
            getIconButtonStyle(
              getSecondaryColor(),
              openChat(context, getSecondaryColor(), getPrimaryColor()),
            ),
          ],
        ),
      ],
    ),
    Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // getLeaderboard(),
        ],
      ),
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        getCardStyle(deck.elementAt(0), 100),
        getCardStyle(deck.elementAt(0), 100),
        getCardStyle(deck.elementAt(0), 100),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        getCardStyle(deck.elementAt(0), 100),
        getCardStyle(deck.elementAt(0), 100),
        getCardStyle(deck.elementAt(0), 100),
      ],
    )
  ]);
}
