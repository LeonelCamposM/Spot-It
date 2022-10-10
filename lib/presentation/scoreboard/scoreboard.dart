import 'package:flutter/material.dart';
import 'package:spot_it_game/presentation/core/focus_box.dart';
import 'package:spot_it_game/presentation/home/home.dart';
import 'package:spot_it_game/presentation/game/game.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:spot_it_game/presentation/core/loading_widget.dart';
import 'package:spot_it_game/presentation/core/get_children_with_icon.dart';
import 'package:spot_it_game/presentation/core/button_style.dart';

import 'package:spot_it_game/presentation/scoreboard/colors.dart';

class ScoreboardPage extends StatefulWidget {
  static String routeName = '/scoreboard'; // /scoreboard
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
    addRoom();
  }

  Future<void> addRoom() async {
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getPrimaryColor(),
      appBar: AppBar(
        title: const Text('Resultados'),
        automaticallyImplyLeading: false,
        backgroundColor: getSecondaryColor(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: isLoading ? const LoadingWidget() : const _RoomWidget(),
        ),
      ),
    );
  }
}

class _RoomWidget extends StatefulWidget {
  const _RoomWidget({Key? key}) : super(key: key);

  @override
  State<_RoomWidget> createState() => _RoomWidgetState();
}

class _RoomWidgetState extends State<_RoomWidget> {
  final ButtonStyle style = getButtonStyle(650, 85, 30.0, getSecondaryColor());

  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                getChildrenWithIcon(
                    context,
                    const Icon(Icons.home),
                    getSecondaryColor(),
                    MaterialPageRoute(builder: (context) => const HomePage())),
                getChildrenWithIcon(
                    context,
                    const Icon(Icons.replay),
                    getSecondaryColor(),
                    MaterialPageRoute(builder: (context) => const GamePage())),
              ],
            )),
        getFocusBox(
            Column(
              children: [
                Flexible(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("", style: TextStyle(fontSize: 20.0)),
                      const Text("Tabla de posiciones",
                          style: TextStyle(fontSize: 20.0),
                          textAlign: TextAlign.center),
                      getChildrenWithIcon(
                          context,
                          const Icon(Icons.list),
                          getSecondaryColor(),
                          MaterialPageRoute(
                              builder: (context) => const GamePage())),
                    ],
                  ),
                ),
                const Text("", style: TextStyle(fontSize: 40.0)),
                SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    primaryYAxis:
                        NumericAxis(minimum: 0, maximum: 30, interval: 10),
                    tooltipBehavior: _tooltip,
                    series: <ChartSeries<_ChartData, String>>[
                      ColumnSeries<_ChartData, String>(
                          dataSource: data,
                          xValueMapper: (_ChartData data, _) => data.x,
                          yValueMapper: (_ChartData data, _) => data.y,
                          name: 'Puntos',
                          color: getColumnColor())
                    ])
              ],
            ),
            500,
            700), //focus box
      ],
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
