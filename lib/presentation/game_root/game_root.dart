import 'package:flutter/material.dart';
import 'package:spot_it_game/presentation/game/game.dart';
import 'package:spot_it_game/presentation/register_room/register_room.dart';
import 'package:spot_it_game/presentation/scoreboard/scoreboard.dart';
import 'package:spot_it_game/presentation/waiting_room/waiting_room.dart';

enum NavigationState {
  game,
  waitingRoom,
  scoreboardRoom,
}

class GameRootPage extends StatefulWidget {
  static String routeName = '/waiting_room';
  const GameRootPage({Key? key}) : super(key: key);

  @override
  State<GameRootPage> createState() => _GameRootPageState();
}

class _GameRootPageState extends State<GameRootPage> {
  var navState = NavigationState.scoreboardRoom;
  var args;

  callback(NavigationState state, dynamic args) {
    setState(() {
      print('12callback');
      print(state);
      navState = state;
      this.args = args;
    });
  }

  @override
  Widget build(BuildContext context) {
    late Widget page;
    // final waitingRoomArgs =
    //     ModalRoute.of(context)!.settings.arguments as WaitingRoomArgs;
    WaitingRoomArgs waitingRoomArgs =
        WaitingRoomArgs(false, "tXvas8dJ7XiPntUe8oOG", "1", "Anuel");

    switch (navState) {
      case NavigationState.waitingRoom:
        page = WaitingRoomPage(args: waitingRoomArgs, setParentState: callback);
        break;
      case NavigationState.game:
        page = GamePage(args: waitingRoomArgs, setParentState: callback);
        break;
      case NavigationState.scoreboardRoom:
        page = ScoreboardPage(args: waitingRoomArgs, setParentState: callback);
    }
    return page;
  }
}
