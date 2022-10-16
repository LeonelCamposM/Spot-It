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
  List<String> links = [
    "Creador: Angie Sofia Castillo Campos",
    "Creador: Nayeri Azofeifa Porras",
    "Creador: Jeremy Vargas Artavia",
    "Creador: Leonel Campos Murillo",
    "Icono: https://www.dobblegame.com/es/inicio/",
    "Ancla: https://www.pngfind.com/mpng/TbmJxJ_anchor-anchor-clipart-hd-png-download/",
    "Manzana: https://toppng.com/apple-for-teachers-transparent-teacher-apple-PNG-free-PNG-Images_280053",
    "Bomba: https://www.pngwing.com/en/free-png-byisd",
    "Cactus: https://pngtree.com/freepng/hand-drawn-cute-cactus_4210174.html",
    "Candela: FALTA",
    "Zanahoria: https://clipartix.com/carrot-clipart-image-55597/",
    "Queso: https://www.pngwing.com/en/free-png-btzwp",
    "Caballo de Ajedrez: https://www.cleanpng.com/png-chess-knight-royalty-free-clip-art-hand-painted-eu-440623/"
        "Martillo: https://es.vexels.com/png-svg/vista-previa/198054/martillo-plano"
        "Corazón: https://www.pngwing.com/es/free-png-bewwy",
    "Cubos de hielo: https://www.pngwing.com/es/free-png-nulrc",
    "Iglú: https://www.pngwing.com/es/free-png-bruhl",
    "Llave: https://www.pngwing.com/es/free-png-ntksz",
    "Mariquita: https://www.pngwing.com/es/free-png-zpnqa",
    "Bombillo: https://www.pngwing.com/es/free-png-zxhea",
    "Rayo: https://www.pngwing.com/es/free-png-ztsph",
    "Candado: https://www.pngwing.com/es/free-png-ijglf",
    "Hoja de arce: https://www.pngwing.com/es/free-png-dsjzl",
    "Biberón: https://www.pngwing.com/es/free-png-pdfdg",
    "Luna: https://flyclipart.com/pictures-of-crescent-moon-png-crescent-moon-png-672718",
    "Signo No Entrar: https://www.discountsafetysignsaustralia.com.au/products/regulatory-road-signs/no-entry-sign-regulatory/",
    "Espantapájaros: http://clipart-library.com/clip-art/scarecrow-clipart-transparent-15.htm",
    "Lápiz: https://www.kindpng.com/imgv/xmTxiT_pencil-colored-drawing-mechanical-clip-art-yellow-cliparts/",
    "Pájaro: https://www.freeiconspng.com/images/bird-purple-png-icon",
    "Gato: https://clipartcraft.com/explore/Cat-clipart-purple/",
    "Signo de pregunta: https://illustcut.com/?p=2757",
    "Labios: http://clipart-library.com/lip-cartoon.html",
    "Tijeras: https://www.iconsdb.com/purple-icons/scissors-6-icon.html",
    "Calavera con huesos: https://www.onlinewebfonts.com/icon/493161",
    "Copo de nieve: https://www.vectorstock.com/royalty-free-vector/snow-flake-icon-winter-symbol-vector-27559547",
    "Hombre de nieve: https://maison-lachenal.fr/menu-des-fetes/"
  ];
  @override
  Widget build(BuildContext context) {
    //Arrow back icon to get to the home page
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getChildrenWithIcon(
                context,
                const Icon(Icons.arrow_back),
                getSecondaryColor(),
                MaterialPageRoute(builder: (context) => const HomePage())),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            getText("Créditos", SizeConfig.blockSizeHorizontal * 2,
                Alignment.center),
            SizedBox(
                height: SizeConfig.blockSizeVertical * 80,
                width: SizeConfig.blockSizeHorizontal * 80,
                child: getVerticalList(links)),
          ],
        ),
        const Text(""),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(""),
              getTransparentFocusBox(
                  getText(text[index], SizeConfig.blockSizeHorizontal * 1.5,
                      Alignment.centerLeft),
                  SizeConfig.blockSizeVertical * 10,
                  SizeConfig.blockSizeHorizontal * 43),
              const Text(""),
            ],
          ),
        ),
      ));
}
