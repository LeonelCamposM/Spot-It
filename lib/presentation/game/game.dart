import 'package:flutter/material.dart';
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
      backgroundColor: const Color.fromARGB(100, 156, 33, 201),
      appBar: AppBar(
        title: const Text('Juego'),
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(100, 109, 31, 138),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      iconSize: 30.0,
                      icon: const Icon(Icons.home),
                      color: Colors.white,
                      hoverColor: const Color.fromARGB(100, 109, 31, 138),
                      alignment: Alignment.topLeft,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        );
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      iconSize: 30.0,
                      icon: const Icon(Icons.question_mark_rounded),
                      color: Colors.white,
                      hoverColor: const Color.fromARGB(100, 109, 31, 138),
                      alignment: Alignment.topLeft,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        );
                      },
                    ),
                    const SizedBox(
                      width: 30,
                      height: 30,
                    ),
                    IconButton(
                      iconSize: 30.0,
                      icon: const Icon(Icons.chat),
                      color: Colors.white,
                      hoverColor: const Color.fromARGB(100, 109, 31, 138),
                      alignment: Alignment.topLeft,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              width: 30,
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        getLeaderboard(),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ],
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
          ]
        ),
  );
}

Align getText(String data, double fontSize, Alignment alignment){
  return Align(
    alignment: alignment,
    child: Padding(
      padding: const EdgeInsets.all(9.0),
      child: Text(
        data, 
        style: TextStyle(fontSize: fontSize),
      ),
    ),
  );
}

