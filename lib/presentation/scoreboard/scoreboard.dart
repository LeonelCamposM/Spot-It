import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:spot_it_game/domain/scoreboard/scoreboard.dart';
import 'package:spot_it_game/application/scoreboard/scoreboard_use_case.dart';
import 'package:spot_it_game/infrastructure/scoreboard/scoreboard_repository.dart';
import 'package:spot_it_game/presentation/core/focus_box.dart';
import 'package:spot_it_game/presentation/home/home.dart';
import 'package:spot_it_game/presentation/game/game.dart';
import 'package:spot_it_game/presentation/scoreboard/scorelist.dart';
import 'package:spot_it_game/presentation/core/loading_widget.dart';
import 'package:spot_it_game/presentation/core/get_children_with_icon.dart';
import 'package:spot_it_game/presentation/core/button_style.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/scoreboard/colors.dart';
import 'package:spot_it_game/presentation/core/icon_button_style.dart';

class ScoreboardPage extends StatefulWidget {
  static String routeName = '/scoreboard';
  const ScoreboardPage({Key? key}) : super(key: key);
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
          child: isLoading ? const LoadingWidget() : const _ScoreboardWidget(),
        ),
      ),
    );
  }
}

class _ScoreboardWidget extends StatefulWidget {
  const _ScoreboardWidget({Key? key}) : super(key: key);

  @override
  State<_ScoreboardWidget> createState() => _ScoreboardWidgetState();
}

class _ScoreboardWidgetState extends State<_ScoreboardWidget> {
  final ButtonStyle style = getButtonStyle(650, 85, 30.0, getSecondaryColor());

  late List<Scoreboard> dataForGraph = [];
  late List<Scoreboard> dataForList = [];
  late TooltipBehavior _tooltip;
  final scoreboardUseCase =
      ScoreboardUseCase(ScoreboardRepository(FirebaseFirestore.instance));

  @override
  void initState() {
    // Data for demostration
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
    getScoreLeaders();
  }

  Future<void> getScoreLeaders() async {
    final scoreboard =
        await scoreboardUseCase.getFinalScoreboard("jTKFlTMyk0Rw24pdPcmv");
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
    setState(() {
      dataForGraph = scoreLeadersList;
      dataForList = scoreboardList;
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
                getNavigationButtons(context),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  // Main screen
                  child: getFocusBox(
                      Column(
                        children: [
                          // Title and button of the main screen
                          getHeader(context, dataForList),
                          const Text("", style: TextStyle(fontSize: 40.0)),
                          // Graph of Columns
                          getBarChart(_tooltip, dataForGraph)
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
Row getNavigationButtons(context) {
  return Row(
    children: [
      getChildrenWithIcon(context, const Icon(Icons.home), getSecondaryColor(),
          MaterialPageRoute(builder: (context) => const HomePage())),
      getChildrenWithIcon(
          context,
          const Icon(Icons.replay),
          getSecondaryColor(),
          MaterialPageRoute(builder: (context) => const GamePage())),
    ],
  );
}

// @param context: Build context
// @param dataForList: Scoreboard data in list
// @return Flexible with tittle and navigation list icon
Flexible getHeader(context, List<Scoreboard> dataForList) {
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
              openList(context, dataForList, getSecondaryColor(),
                  getPrimaryColor())),
        ),
      ],
    ),
  );
}

// @param _tooltip: Component used in Syncfunctions charts
// @param dataForGraph: Data to be displayed on the chart
// @return SizedBox with Column Chart of the data
SizedBox getBarChart(TooltipBehavior _tooltip, List<Scoreboard> dataForGraph) {
  return SizedBox(
    child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(minimum: 0, maximum: 30, interval: 10),
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
