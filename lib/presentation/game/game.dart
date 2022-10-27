import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/application/cards/deck_use_case.dart';
import 'package:spot_it_game/application/scoreboard/scoreboard_use_case.dart';
import 'package:spot_it_game/domain/cards/card_model.dart';
import 'package:spot_it_game/infrastructure/cards/card_repository.dart';
import 'package:spot_it_game/infrastructure/players/eventListeners/on_table_update.dart';
import 'package:spot_it_game/infrastructure/rooms/eventListeners/on_round_update.dart';
import 'package:spot_it_game/infrastructure/scoreboard/scoreboard_repository.dart';
import 'package:spot_it_game/presentation/chat/chat.dart';
import 'package:spot_it_game/presentation/core/get_children_with_icon.dart';
import 'package:spot_it_game/presentation/core/icon_button_style.dart';
import 'package:spot_it_game/presentation/core/loading_widget.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/core/text_button_style.dart';
import 'package:spot_it_game/presentation/core/text_style.dart';
import 'package:spot_it_game/presentation/game/colors.dart';
import 'package:spot_it_game/presentation/game/rules.dart';
import 'package:spot_it_game/presentation/home/home.dart';
import 'package:spot_it_game/presentation/scoreboard/scoreboard.dart';
import 'package:spot_it_game/presentation/waiting_room/waiting_room.dart';
import 'package:spot_it_game/domain/scoreboard/scoreboard.dart';

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
  int amountOfPlayers = 2;

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
          getTextButton(
              "scoreboard",
              SizeConfig.safeBlockHorizontal * 20,
              SizeConfig.safeBlockVertical * 10,
              SizeConfig.safeBlockHorizontal * 2,
              getSecondaryColor(), () {
            Navigator.pushNamed(context, ScoreboardPage.routeName,
                arguments: ScoreboardRoomArgs(args.isHost, args.roomID));
          }),
        ]),
        Row(
          children: [
            OnRoundUpdate(roomID: args.roomID),
            OnTableUpdate(
              roomID: args.roomID,
              deckData: deckData,
            )
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
                getLeaderboard(args.roomID),
              ],
            ),
          ],
        ),
      ],
    )
  ]);
}

Column getLeaderboard(String roomID) {
  final scoreboardUseCase =
      ScoreboardUseCase(ScoreboardRepository(FirebaseFirestore.instance));
  return (Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        width: SizeConfig.blockSizeHorizontal * 12,
        height: SizeConfig.blockSizeVertical * 40,
        decoration: const BoxDecoration(
          color: Color.fromARGB(100, 109, 31, 138),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            getText("Posición", SizeConfig.blockSizeHorizontal * 1.2,
                Alignment.topCenter),
            scoreboardUseCase.onScoreboardUpdate(roomID),
          ],
        ),
      ),
    ],
  ));
}

// @param scoreboard: Scoreboard to be draw
// @return Sized box with a vertical list of the scoreboard
Widget getScoreboardList(List<Scoreboard> scoreboard) {
  return SizedBox(
    width: SizeConfig.blockSizeHorizontal * 12,
    height: SizeConfig.blockSizeVertical * 30,
    child: ListView(
        scrollDirection: Axis.vertical,
        children: List.generate(
          scoreboard.length,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Row(
              children: [
                getText(
                    scoreboard[index].nickname +
                        " " +
                        scoreboard[index].score.toString(),
                    SizeConfig.blockSizeHorizontal * 1.2,
                    Alignment.centerLeft),
              ],
            ),
          ),
        )),
  );
}

// arguments for ScoreboardRoom
class ScoreboardRoomArgs {
  final bool isHost;
  final String roomID;
  ScoreboardRoomArgs(this.isHost, this.roomID);
}
