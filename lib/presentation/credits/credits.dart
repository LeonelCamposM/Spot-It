import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spot_it_game/domain/clients/client_service.dart';
import 'package:spot_it_game/presentation/core/button_style.dart';
import 'package:spot_it_game/presentation/core/focus_box.dart';
import 'package:spot_it_game/presentation/core/get_children_with_icon.dart';
import 'package:spot_it_game/presentation/core/loading_widget.dart';
import 'package:spot_it_game/presentation/core/text_style.dart';
import 'package:spot_it_game/presentation/game/rules.dart';
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
  List<String> names = [
    "Angie Sofia Castillo Campos ",
    "Nayeri Azofeifa Porras",
    "Jeremy Vargas Artavia",
    "Leonel Campos Murillo",
  ];
  List<String> links = [
    "Icono: https://www.dobblegame.com/es/inicio/",
    "Anchor:https://www.pngfind.com/mpng/TbmJxJ_anchor-anchor-clipart-hd-png-download/",
    "Apple: https://toppng.com/apple-for-teachers-transparent-teacher-apple-PNG-free-PNG-Images_280053",
    "Bomb: https://www.pngwing.com/en/free-png-byisd",
    "Cactus: https://pngtree.com/freepng/hand-drawn-cute-cactus_4210174.html",
    "Candle: ",
    "Carrot: https://clipartix.com/carrot-clipart-image-55597/",
    "Cheese: https://www.pngwing.com/en/free-png-btzwp",
    "ChessKnight: https://www.cleanpng.com/png-chess-knight-royalty-free-clip-art-hand-painted-eu-440623/"
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
            Column(
              children: [
                Column(
                  children: [
                    getText("Creadores", SizeConfig.blockSizeHorizontal * 2,
                        Alignment.center),
                    SizedBox(
                        height: SizeConfig.blockSizeVertical * 30,
                        width: SizeConfig.blockSizeHorizontal * 45,
                        child: getVerticalList(names)),
                    getText("Referencias", SizeConfig.blockSizeHorizontal * 2,
                        Alignment.center),
                    SizedBox(
                        height: SizeConfig.blockSizeVertical * 30,
                        width: SizeConfig.blockSizeHorizontal * 45,
                        child: getVerticalList(links)),
                  ],
                ),
              ],
            ),
            SizeConfig.safeBlockVertical * 80,
            SizeConfig.safeBlockHorizontal * 45), //focus box
      ],
    );
  }
}

// @param text: references or creators' names or images' links
// @return Container with vertical list references
ListView getVerticalList(List<String> text) {
  return ListView(
      scrollDirection: Axis.vertical,
      children: List.generate(
        text.length,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              getTransparentFocusBox(
                  getText(text[index], SizeConfig.blockSizeHorizontal * 1.5,
                      Alignment.centerLeft),
                  SizeConfig.blockSizeVertical * 10,
                  SizeConfig.blockSizeHorizontal * 43)
            ],
          ),
        ),
      ));
}
