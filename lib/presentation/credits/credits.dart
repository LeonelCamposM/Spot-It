import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spot_it_game/domain/clients/client_service.dart';
import 'package:spot_it_game/presentation/core/button_style.dart';
import 'package:spot_it_game/presentation/core/focus_box.dart';
import 'package:spot_it_game/presentation/core/get_children_with_icon.dart';
import 'package:spot_it_game/presentation/core/loading_widget.dart';
import 'package:spot_it_game/presentation/core/text_style.dart';
import 'package:spot_it_game/presentation/home/colors.dart';
import 'package:spot_it_game/presentation/home/home.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';

class CreditsPage extends StatefulWidget {
  static String routeName = '/credits';
  const CreditsPage({Key? key}) : super(key: key);
  @override
  State<CreditsPage> createState() => _CreditsPageState();
}

class _CreditsPageState extends State<CreditsPage> {
  _CreditsPageState() : isLoading = true;
  bool isLoading;

  @override
  void initState() {
    super.initState();
    addRoom();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  Future<void> addRoom() async {
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: getPrimaryColor(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: isLoading ? const LoadingWidget() : const _CreditsWidget(),
        ),
      ),
    );
  }
}

class _CreditsWidget extends StatefulWidget {
  const _CreditsWidget({Key? key}) : super(key: key);

  @override
  State<_CreditsWidget> createState() => _CreditsWidgetState();
}

class _CreditsWidgetState extends State<_CreditsWidget> {
  final ClientService clientService = ClientService();
  final ButtonStyle style = getButtonStyle(650, 85, 30.0, getSecondaryColor());
  List<IconData> icons = [
    Icons.face,
    Icons.face,
    Icons.face,
    Icons.face,
  ];
  List<String> names = [
    "Angie Sofia Castillo Campos ",
    "Nayeri Azofeifa Porras",
    "Jeremy Vargas Artavia",
    "Leonel Campos Murillo",
  ];
  List<String> images = [
    "assets/logo.png",
  ];
  List<String> links = ["Icono: https://www.dobblegame.com/es/inicio/"];
  List<IconData> temporal = [
    Icons.front_hand,
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Arrow back icon to get to the home page
                getChildrenWithIcon(
                    context,
                    const Icon(Icons.arrow_back),
                    getSecondaryColor(),
                    MaterialPageRoute(builder: (context) => const HomePage())),
              ],
            )),
        //Main screen
        getFocusBox(
            Column(children: [
              Flexible(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // const Text(""),
                        getText("Creadores", SizeConfig.blockSizeHorizontal * 2,
                            Alignment.center),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                            height: SizeConfig.blockSizeVertical * 70,
                            width: SizeConfig.blockSizeHorizontal * 45,
                            child: getVerticalList(names, icons)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // const Text(""),
                        getText(
                            "Referencias",
                            SizeConfig.blockSizeHorizontal * 2,
                            Alignment.center),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                            height: SizeConfig.blockSizeVertical * 70,
                            width: SizeConfig.blockSizeHorizontal * 45,
                            child: getVerticalList(links, temporal)),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
            SizeConfig.safeBlockVertical * 80,
            SizeConfig.safeBlockHorizontal * 45), //focus box
      ],
    );
  }
}

// @param text: references or creators' names
// @param icons: icons for creators
// @return Container with vertical list references
ListView getVerticalList(List<String> text, List<IconData> icons) {
  return ListView(
      scrollDirection: Axis.vertical,
      children: List.generate(
        text.length,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  width: SizeConfig.blockSizeHorizontal * 5,
                  height: SizeConfig.blockSizeVertical * 10,
                  decoration: BoxDecoration(
                      color: getSecondaryColor(), shape: BoxShape.circle),
                  child: Icon(
                    icons[index],
                    size: SizeConfig.blockSizeVertical * 5,
                  )),
              const Text("   "),
              getFocusBox(
                  getText(text[index], SizeConfig.blockSizeHorizontal * 1.5,
                      Alignment.centerLeft),
                  SizeConfig.blockSizeVertical * 10,
                  SizeConfig.blockSizeHorizontal * 37),
            ],
          ),
        ),
      ));
}
