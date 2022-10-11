import 'package:flutter/material.dart';
import 'package:spot_it_game/presentation/core/focus_box.dart';
import 'package:spot_it_game/presentation/home/home.dart';
import 'package:spot_it_game/presentation/game/game.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:spot_it_game/presentation/core/loading_widget.dart';
import 'package:spot_it_game/presentation/core/get_children_with_icon.dart';
import 'package:spot_it_game/presentation/core/button_style.dart';
import 'package:flutter/services.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/scoreboard/colors.dart';

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

  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    // Data for demostration
    data = [
      _ChartData('Sofia', 20),
      _ChartData('Leonel', 30),
      _ChartData('Nayeri', 10)
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
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
                          getHeader(context),
                          const Text("", style: TextStyle(fontSize: 40.0)),
                          // Graph of Columns
                          getBarChart(_tooltip, data)
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
// @return Flexible with tittle and navigation list icon
Flexible getHeader(context) {
  return Flexible(
    flex: 2,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("", style: TextStyle(fontSize: 20.0)),
        const Text("Tabla de posiciones",
            style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
        Padding(
          padding: const EdgeInsets.only(right: 13, top: 5),
          child: getChildrenWithIcon(
              context,
              const Icon(Icons.list),
              getSecondaryColor(),
              MaterialPageRoute(builder: (context) => const GamePage())),
        ),
      ],
    ),
  );
}

// @param _tooltip: Component used in Syncfunctions charts
// @param data: Data to be displayed on the chart
// @return SizedBox with Column Chart of the data
SizedBox getBarChart(TooltipBehavior _tooltip, List<_ChartData> data) {
  return SizedBox(
    child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(minimum: 0, maximum: 30, interval: 10),
        tooltipBehavior: _tooltip,
        series: <ChartSeries<_ChartData, String>>[
          ColumnSeries<_ChartData, String>(
              dataSource: data,
              xValueMapper: (_ChartData data, _) => data.x,
              yValueMapper: (_ChartData data, _) => data.y,
              name: 'Puntos',
              color: getColumnColor())
        ]),
    height: SizeConfig.safeBlockVertical * 50,
    width: SizeConfig.safeBlockHorizontal * 50,
  );
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
