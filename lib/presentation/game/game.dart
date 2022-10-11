import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/application/cards/deck_use_case.dart';
import 'package:spot_it_game/domain/cards/card_model.dart';
import 'package:spot_it_game/infrastructure/cards/card_repository.dart';
import 'package:spot_it_game/presentation/chat/chat.dart';
import 'package:spot_it_game/presentation/core/card_style.dart';
import 'package:spot_it_game/presentation/core/get_children_with_icon.dart';
import 'package:spot_it_game/presentation/core/icon_button_style.dart';
import 'package:spot_it_game/presentation/core/loading_widget.dart';
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
    return Scaffold(
      backgroundColor: getPrimaryColor(),
      appBar: AppBar(
        title: const Text('Juego'),
        automaticallyImplyLeading: false,
        backgroundColor: getSecondaryColor(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Center(
          child: isLoading? const LoadingWidget(): _GameWidget(deckData: deckData),
        ),
      ),
    );
  }
}

class _GameWidget extends StatefulWidget {
  final Iterable<CardModel> deckData;
  const _GameWidget({Key? key, required this.deckData}) : super(key: key);

  @override
  State<_GameWidget> createState() => _GameWidgetState(deckData);
}

class _GameWidgetState extends State<_GameWidget> {
  final Iterable<CardModel> deckData;
  _GameWidgetState(this.deckData);
  Color secondaryColor = getPrimaryColor();
  Color primaryColor = getSecondaryColor();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: getGameScreenWidget(context, deckData),
      ),
    );
  }
}



Container getLeaderboard(){
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



List<Widget> getGameScreenWidget(BuildContext context, Iterable<CardModel> deckData){
  return (
    [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getChildrenWithIcon(context, const Icon(Icons.home), getSecondaryColor(),
              MaterialPageRoute(builder: (context) => const HomePage())
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: getChildrenWithIcon(context, const Icon(Icons.question_mark_rounded), getSecondaryColor(),
                  MaterialPageRoute(builder: (context) => const HomePage())
                ),
              ),
              getIconButtonStyle(getSecondaryColor(), openChat(context, getSecondaryColor(), getPrimaryColor()),)
            ],
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child:
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(180.0, 0.0, 0.0, 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0.0, 40.0, 15.0, 0.0),
                                child: getCardStyle(deckData.elementAt(0), 120),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: getCardStyle(deckData.elementAt(0), 120),
                            ),
                            Flexible(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(15.0, 40.0, 0.0, 0.0),
                                child: getCardStyle(deckData.elementAt(0), 120),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(180.0, 0.0, 0.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 70.0, 0.0),
                                child: getCardStyle(deckData.elementAt(0), 120),
                              ),
                            ),
                            const SizedBox(
                              width: 120,
                              height: 120,
                              child: Image(
                                image: AssetImage('assets/logo.png'),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(70.0, 0.0, 0.0, 0.0),
                                child: getCardStyle(deckData.elementAt(0), 120),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ), 
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              getLeaderboard(),
            ],
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 150.0),
                      child: getCardStyle(deckData.elementAt(0), 120),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: getCardStyle(deckData.elementAt(0), 250),
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 150.0),
                      child: getCardStyle(deckData.elementAt(0), 120),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    ]
  );
}
