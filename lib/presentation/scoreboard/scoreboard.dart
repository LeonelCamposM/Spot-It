import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spot_it_game/application/player/player_use_case.dart';
import 'package:spot_it_game/application/rooms/rooms_use_case.dart';
import 'package:spot_it_game/domain/players/player.dart';
import 'package:spot_it_game/domain/rooms/room.dart';
import 'package:spot_it_game/infrastructure/players/player_repository.dart';
import 'package:spot_it_game/infrastructure/rooms/rooms_repository.dart';
import 'package:spot_it_game/infrastructure/scoreboard/eventListeners/on_play_again.dart';
import 'package:spot_it_game/presentation/game_root/game_root.dart';
import 'package:spot_it_game/presentation/register_room/available_icons.dart';
import 'package:spot_it_game/presentation/register_room/register_room.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:spot_it_game/domain/scoreboard/scoreboard.dart';
import 'package:spot_it_game/application/scoreboard/scoreboard_use_case.dart';
import 'package:spot_it_game/infrastructure/scoreboard/scoreboard_repository.dart';
import 'package:spot_it_game/presentation/core/focus_box.dart';
import 'package:spot_it_game/presentation/home/home.dart';
import 'package:spot_it_game/presentation/scoreboard/scorelist.dart';
import 'package:spot_it_game/presentation/core/loading_widget.dart';
import 'package:spot_it_game/presentation/core/get_children_with_icon.dart';
import 'package:spot_it_game/presentation/core/button_style.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/scoreboard/colors.dart';
import 'package:spot_it_game/presentation/core/icon_button_style.dart';

// ignore: must_be_immutable
class ScoreboardPage extends StatefulWidget {
  static String routeName = '/scoreboard';
  PlayerInfo args;
  Function setParentState;
  ScoreboardPage({Key? key, required this.args, required this.setParentState})
      : super(key: key);
  @override
  State<ScoreboardPage> createState() => _ScoreboardPageState();
}

class _ScoreboardPageState extends State<ScoreboardPage> {
  _ScoreboardPageState() : isLoading = true;
  bool isLoading;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    getWinners();
  }

  Future<void> getWinners() async {
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: getPrimaryColor(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: isLoading
              ? const LoadingWidget()
              : _ScoreboardWidget(
                  args: widget.args, setParentState: widget.setParentState),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _ScoreboardWidget extends StatefulWidget {
  PlayerInfo args;
  Function setParentState;
  _ScoreboardWidget(
      {Key? key, required this.args, required this.setParentState})
      : super(key: key);

  @override
  State<_ScoreboardWidget> createState() => _ScoreboardWidgetState();
}

class _ScoreboardWidgetState extends State<_ScoreboardWidget> {
  final ButtonStyle style = getButtonStyle(650, 85, 30.0, getSecondaryColor());
  late TooltipBehavior _tooltip;
  final scoreboardUseCase =
      ScoreboardUseCase(ScoreboardRepository(FirebaseFirestore.instance));
  int maximumPoints = 0;
  List<Scoreboard> dataForList = [];
  List<Scoreboard> dataForGraph = [];
  List<IconData> playerIcons = [];

  @override
  initState() {
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getScoreboard(widget.args.roomID);
    getMaximumPoints(widget.args.roomID);
  }

  Future<void> getMaximumPoints(String roomID) async {
    final roomUseCase = RoomUseCase(RoomRepository(FirebaseFirestore.instance));
    int roundCount = await roomUseCase.getMaximumRoundCount(roomID);
    setState(() {
      maximumPoints = roundCount;
    });
  }

  // @param roomID: The roomID of the desired scoreboard
  // @brief: Sets the data for graph and listed scoreboard and the player's icons
  Future<void> getScoreboard(String roomID) async {
    final scoreboard = await scoreboardUseCase.getFinalScoreboard(roomID);
    List<Scoreboard> scoreboardList = scoreboard.toList();
    scoreboardList.sort((a, b) => a.score.compareTo(b.score));
    scoreboardList = scoreboardList.reversed.toList();
    var counter = 0;
    List<Scoreboard> scoreLeadersList = [];
    for (var element in scoreboardList) {
      if (counter < 3) {
        scoreLeadersList.add(element);
        counter += 1;
      } else {
        break;
      }
    }
    scoreLeadersList.shuffle();
    await getPlayersIcons(scoreboardList, roomID);
    setState(() {
      dataForGraph = scoreLeadersList;
      dataForList = scoreboardList;
    });
  }

  // @param scoreboard: the scoreboard of the game
  // @param roomID: the roomID of the game
  // @brief: gets the players icons to be displayed in the list
  Future<void> getPlayersIcons(
      List<Scoreboard> scoreboard, String roomID) async {
    final playerUseCase =
        PlayerUseCase(PlayerRepository(FirebaseFirestore.instance));
    List<Player> nicknames = [];
    List<IconData> icons = [];
    List<Player> players = await playerUseCase.getPlayers(roomID);
    for (var element in scoreboard) {
      nicknames.add(Player(
          element.nickname,
          players
              .firstWhere((player) => player.nickname == element.nickname)
              .icon,
          "",
          0,
          0));
    }
    for (var element in nicknames) {
      icons.add(getRoomIcon(element.icon));
    }
    setState(() {
      playerIcons = icons;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Home and replay icons
                getNavigationButtons(
                    context, widget.setParentState, widget.args),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  // Main screen
                  child: getFocusBox(
                      Column(
                        children: [
                          // Title and button of the main screen
                          getHeader(context, dataForList, playerIcons),
                          const Text("", style: TextStyle(fontSize: 40.0)),
                          // Graph of Columns
                          getBarChart(_tooltip, dataForGraph, maximumPoints)
                        ],
                      ),
                      SizeConfig.safeBlockVertical * 85,
                      SizeConfig.safeBlockHorizontal * 60),
                ),
                const Text("", style: TextStyle(fontSize: 40.0)),
              ],
            )),
      ],
    );
  }
}

// @param context: Build context
// @return Row with home and replay navigation icons
Row getNavigationButtons(context, Function setParentState, args) {
  return Row(
    children: [
      getChildrenWithIcon(context, const Icon(Icons.home), getSecondaryColor(),
          MaterialPageRoute(builder: (context) => const HomePage())),
      args.isHost == true
          ? getIconButtonStyle(
              getSecondaryColor(),
              IconButton(
                icon: const Icon(Icons.replay),
                iconSize: getIconSize(),
                alignment: Alignment.center,
                onPressed: () {
                  playAgain(args);
                  setParentState(NavigationState.waitingRoom, null);
                },
              ),
            )
          : OnPlayAgain(args: args, setParentState: setParentState),
    ],
  );
}

// @param context: Build context
// @param dataForList: Scoreboard data in list
// @return Flexible with tittle and navigation list icon
Flexible getHeader(
    context, List<Scoreboard> dataForList, List<IconData> icons) {
  return Flexible(
    flex: 2,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("", style: TextStyle(fontSize: 20.0)),
        const Text("Tabla de posiciones",
            style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
        Padding(
          padding: const EdgeInsets.only(right: 15, top: 5),
          // Open the list of scores as a popup
          child: getIconButtonStyle(
              getSecondaryColor(),
              openList(context, dataForList, icons, getSecondaryColor(),
                  getPrimaryColor())),
        ),
      ],
    ),
  );
}

// @param _tooltip: Component used in Syncfunctions charts
// @param dataForGraph: Data to be displayed on the chart
// @return SizedBox with Column Chart of the data
SizedBox getBarChart(TooltipBehavior _tooltip, List<Scoreboard> dataForGraph,
    int maximumPoints) {
  return SizedBox(
    child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(
            minimum: 0, maximum: maximumPoints.toDouble(), interval: 1),
        tooltipBehavior: _tooltip,
        series: <ChartSeries<Scoreboard, String>>[
          ColumnSeries<Scoreboard, String>(
              dataSource: dataForGraph,
              xValueMapper: (Scoreboard dataForGraph, _) =>
                  dataForGraph.nickname,
              yValueMapper: (Scoreboard dataForGraph, _) => dataForGraph.score,
              name: 'Puntos',
              color: getColumnColor())
        ]),
    height: SizeConfig.safeBlockVertical * 50,
    width: SizeConfig.safeBlockHorizontal * 50,
  );
}

Future<void> playAgain(args) async {
  final roomCollection =
      FirebaseFirestore.instance.collection('Room').doc(args.roomID);
  final playerCollection = FirebaseFirestore.instance
      .collection('Room_Player')
      .doc(args.roomID)
      .collection("players");
  var snapshots = await playerCollection.get();
  for (var element in snapshots.docs) {
    element.reference.delete();
  }
  final scoreboardCollection = FirebaseFirestore.instance
      .collection('Room_Scoreboard')
      .doc(args.roomID)
      .collection("Scoreboard");
  var scoreboardSnapshots = await scoreboardCollection.get();
  for (var element in scoreboardSnapshots.docs) {
    element.reference.delete();
  }

  await playerCollection.add(Player(args.playerNickName, args.icon,
          "SpotItLogo,SpotItLogo,SpotItLogo,SpotItLogo,SpotItLogo,SpotItLogo,SpotItLogo,SpotItLogo", 0, 0)
      .toJson());

  await scoreboardCollection.add(Scoreboard(args.playerNickName, 0).toJson());

  await roomCollection
      .update(Room(0, true, false, false, false, false, 4).toJson());
}
