import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/application/cards/deck_use_case.dart';
import 'package:spot_it_game/domain/cards/card_model.dart';
import 'package:spot_it_game/infrastructure/cards/card_repository.dart';
import 'package:spot_it_game/presentation/chat/chat.dart';
import 'package:spot_it_game/presentation/core/get_children_with_icon.dart';
import 'package:spot_it_game/presentation/core/icon_button_style.dart';
import 'package:spot_it_game/presentation/core/loading_widget.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/core/text_style.dart';
import 'package:spot_it_game/presentation/game/card_location.dart';
import 'package:spot_it_game/presentation/game/colors.dart';
import 'package:spot_it_game/presentation/game/rules.dart';
import 'package:spot_it_game/presentation/home/home.dart';
import 'package:spot_it_game/presentation/waiting_room/waiting_room.dart';

class GamePage extends StatefulWidget {
  static String routeName = '/game';
  const GamePage({Key? key}) : super(key: key);
  @override
  State<GamePage> createState() => _GamePagePageState();
}

class _GamePagePageState extends State<GamePage> {
  _GamePagePageState() : isLoading = true;
  CardUseCase cardUseCase =
      CardUseCase(CardRepository(FirebaseFirestore.instance));
  Iterable<CardModel> deckData = [];
  bool isLoading;

  @override
  void initState() {
    super.initState();
    getDeck();
  }

  Future<void> getDeck() async {
    final deck = await cardUseCase.getDeck();
    setState(() {
      deckData = deck;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: getPrimaryColor(),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Center(
          child: isLoading
              ? const LoadingWidget()
              : _GameWidget(deckData: deckData),
        ),
      ),
    );
  }
}

class _GameWidget extends StatefulWidget {
  final Iterable<CardModel> deckData;
  const _GameWidget({Key? key, required this.deckData}) : super(key: key);
  @override
  // ignore: no_logic_in_create_state
  State<_GameWidget> createState() => _GameWidgetState(deckData);
}

class _GameWidgetState extends State<_GameWidget> {
  final Iterable<CardModel> deckData;
  _GameWidgetState(this.deckData);
  Color secondaryColor = getPrimaryColor();
  Color primaryColor = getSecondaryColor();
  int amountOfPlayers = 3;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: getGameScreenWidget(context, deckData, amountOfPlayers),
      ),
    );
  }
}

List<Widget> getGameScreenWidget(
    BuildContext context, Iterable<CardModel> deckData, int amountOfPlayers) {
      Iterable<String> userNames = ["Leo", "Naye", "Jere"];
  final args = ModalRoute.of(context)!.settings.arguments as GameRoomArgs;
  return ([
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          getChildrenWithIcon(
              context,
              const Icon(Icons.home),
              getSecondaryColor(),
              MaterialPageRoute(builder: (context) => const HomePage())),
          // getChildrenWithIcon(
          //     context,
          //     const Icon(Icons.leaderboard),
          //     getSecondaryColor(),
          //     MaterialPageRoute(builder: (context) => const ScoreboardPage()))
        ]),
        Row(
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                    getAmountOfCardsMenu(context, deckData, userNames, amountOfPlayers)),
          ],
        ),
        Row(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    getIconButtonStyle(
                      getSecondaryColor(),
                      openRules(
                          context, getSecondaryColor(), getPrimaryColor()),
                    ),
                    getIconButtonStyle(
                      getSecondaryColor(),
                      openChat(context, getSecondaryColor(), getPrimaryColor(),
                          args.roomID),
                    )
                  ],
                ),
                SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 3,
                    height: SizeConfig.blockSizeHorizontal * 3),
                getLeaderboard(),
              ],
            ),
          ],
        ),
      ],
    )
  ]);
}

Column getLeaderboard() {
  return (Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        width: SizeConfig.blockSizeHorizontal * 12,
        height: SizeConfig.blockSizeHorizontal * 18,
        decoration: const BoxDecoration(
          color: Color.fromARGB(100, 109, 31, 138),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getText("Posición", SizeConfig.blockSizeHorizontal * 1.2,
                Alignment.topCenter),
            getText("1. Leo", SizeConfig.blockSizeHorizontal * 1,
                Alignment.topLeft),
            getText("2. Jere", SizeConfig.blockSizeHorizontal * 1,
                Alignment.topLeft),
            getText("3. Naye", SizeConfig.blockSizeHorizontal * 1,
                Alignment.topLeft),
          ],
        ),
      ),
    ],
  ));
}
