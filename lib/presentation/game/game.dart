import 'package:flutter/material.dart';
import 'package:spot_it_game/presentation/chat/chat.dart';
import 'package:spot_it_game/presentation/core/get_children_with_icon.dart';
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
  _GamePagePageState() : isLoading = true;
  bool isLoading;

  @override
  void initState() {
    super.initState();
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: getGameScreenWidget(context),
        ),
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



List<Widget> getGameScreenWidget(BuildContext context){
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
      Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            getLeaderboard(),
          ],
        ),
      ),
    ]
  );
}
