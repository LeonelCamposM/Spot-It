import 'package:flutter/material.dart';
import 'package:spot_it_game/presentation/game/game.dart';
import 'package:spot_it_game/presentation/register_room/register_room.dart';
import 'package:spot_it_game/presentation/waiting_room/waiting_room.dart';

enum NavigationState {
  game,
  waitingRoom,
}

class GameRootPage extends StatefulWidget {
  static String routeName = '/waiting_room';
  const GameRootPage({Key? key}) : super(key: key);

  @override
  State<GameRootPage> createState() => _GameRootPageState();
}

class _GameRootPageState extends State<GameRootPage> {
  var navState = NavigationState.waitingRoom;
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
    final waitingRoomargs =
        ModalRoute.of(context)!.settings.arguments as WaitingRoomArgs;

    switch (navState) {
      case NavigationState.waitingRoom:
        page = WaitingRoomPage(args: waitingRoomargs, setParentState: callback);
        break;
      case NavigationState.game:
        page = GamePage(args: waitingRoomargs, setParentState: callback);
        break;
    }
    return page;
  }
}
