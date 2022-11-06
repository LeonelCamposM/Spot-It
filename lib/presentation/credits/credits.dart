import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spot_it_game/presentation/core/button_style.dart';
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
  final ButtonStyle style = getButtonStyle(650, 85, 30.0, getSecondaryColor());
  List<String> links = [
    "Angie Sofia Castillo Campos",
    "Nayeri Azofeifa Porras",
    "Jeremy Vargas Artavia",
    "Leonel Campos Murillo",
    "Icono: https://www.dobblegame.com/es/inicio/",
    "Ancla: https://www.pngfind.com/mpng/TbmJxJ_anchor-anchor-clipart-hd-png-download/",
    "Manzana: https://toppng.com/apple-for-teachers-transparent-teacher-apple-PNG-free-PNG-Images_280053",
    "Bomba: https://www.pngwing.com/en/search?q=cartoon+Bomb",
    "Cactus: https://pngtree.com/freepng/hand-drawn-cute-cactus_4210174.html",
    "Candela: https://toppng.com/photo/35948/baboa-nyo-ghynya-shmaa-byda",
    "Zanahoria: https://clipartix.com/carrot-clipart-image-55597/",
    "Queso: https://www.pngwing.com/en/free-png-btzwp",
    "Caballo de Ajedrez: https://www.cleanpng.com/png-chess-knight-royalty-free-clip-art-hand-painted-eu-440623/",
    "Reloj: https://pngtree.com/so/clock-icon",
    "Payaso: s.pngtree.com/freepng/clown-with-big-eye-icon-cartoon-style_5272124.html",
    "Margarita: https://www.pngwing.com/en/free-png-blejj",
    "Dinosaurio: https://www.cleanpng.com/png-royalty-free-dinosaur-cartoon-cute-dinosaur-1445651/",
    "Delfín: https://www.freepik.es/fotos-vectores-gratis/dolphin-jump/2",
    "Dragon: https://www.pngwing.com/es/free-png-birhw",
    "Signo de exclamación: https://www.pngegg.com/en/png-blxfm",
    "Ojo: https://www.flaticon.com/free-icon/cartoon-happy-eyes_64863",
    "Fuego: https://stock.adobe.com/es/images/fire-emoji-flame-icon-isolated-bonfire-sign-emotion-flame-symbol-isolated-on-white-fire-emoji-and-logo-vector-illustration-eps-10/348550501?as_campaign=ftmigration2&as_channel=dpcft&as_campclass=brand&as_source=ft_web&as_camptype=acquisition&as_audience=users&as_content=closure_asset-detail-page",
    "Trébol: https://iconos8.es/icon/z8HLqk3pYtq9/four-leaf-clover",
    "Fantasma: https://www.pngwing.com/en/free-png-bfnrf",
    "Salpicadura verde: https://www.pngwing.com/en/free-png-tania",
    "Martillo: https://es.vexels.com/png-svg/vista-previa/198054/martillo-plano",
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
    "Signo no Entrar: https://www.discountsafetysignsaustralia.com.au/products/regulatory-road-signs/no-entry-sign-regulatory/",
    "Espantapájaros: http://clipart-library.com/clip-art/scarecrow-clipart-transparent-15.htm",
    "Lápiz: https://www.kindpng.com/imgv/xmTxiT_pencil-colored-drawing-mechanical-clip-art-yellow-cliparts/",
    "Pájaro: https://www.freeiconspng.com/images/bird-purple-png-icon",
    "Gato: https://clipartcraft.com/explore/Cat-clipart-purple/",
    "Signo de pregunta: https://illustcut.com/?p=2757",
    "Labios: https://creazilla.com/nodes/69762-lip-clipart",
    "Tijeras: https://www.iconsdb.com/purple-icons/scissors-6-icon.html",
    "Calavera con huesos: https://www.onlinewebfonts.com/icon/493161",
    "Copo de nieve: https://www.vectorstock.com/royalty-free-vector/snow-flake-icon-winter-symbol-vector-27559547",
    "Hombre de nieve: https://maison-lachenal.fr/menu-des-fetes/",
    "Araña: https://www.kindpng.com/imgv/JTJRiJ_spider-spider-icon-free-download-hd-png-download/",
    "Tela de araña: https://www.flaticon.com/free-icon/spiderweb_93223",
    "Sol: https://www.cleanpng.com/png-transparent-cartoon-sun-png-clipart-picture-8464/",
    "Lentes: https://www.pngwing.com/es/free-png-vhqlo",
    "Blanco-objetivo: https://www.freepng.es/png-zmqyjh/",
    "Taxi: https://es.pngtree.com/freepng/taxi-icon-cartoon-style_5230226.html",
    "Tortuga: https://pngtree.com/freepng/hand-drawn-cartoon-tortoise-clipart_5546424.html?share=3",
    "Clave de sol: https://www.flaticon.com/free-icon/treble-clef_2227",
    "Árbol: https://www.flaticon.com/free-icon/fruit-tree_1497192",
    "Gota de agua: https://toppng.com/free-image/free-download-gota-de-agua-png-clipart-drop-clip-art-imagen-de-gotas-de-agua-PNG-free-PNG-Images_165621",
    "Perro: https://dribbble.com/shots/4295728-Pitbull",
    "Yin Yang: https://www.flaticon.es/icono-gratis/simbolo-de-yin-yang_68155",
    "Zebra: https://www.freepng.es/png-muyxmq/"
  ];

  List<IconData> icons = [
    Icons.face,
    Icons.face_outlined,
    Icons.sentiment_satisfied_alt_rounded,
    Icons.insert_emoticon_outlined,
    Icons.front_hand_outlined,
    Icons.anchor_outlined,
    Icons.fiber_manual_record,
    Icons.timer,
    Icons.spa,
    Icons.candlestick_chart,
    Icons.kitchen,
    Icons.local_pizza,
    Icons.bedroom_baby,
    Icons.alarm,
    Icons.face_retouching_natural,
    Icons.local_florist,
    Icons.history_edu,
    Icons.water,
    Icons.castle,
    Icons.priority_high,
    Icons.visibility,
    Icons.local_fire_department,
    Icons.compost,
    Icons.face_retouching_off,
    Icons.color_lens,
    Icons.handyman,
    Icons.favorite,
    Icons.view_in_ar,
    Icons.balcony,
    Icons.key,
    Icons.emoji_nature,
    Icons.tips_and_updates,
    Icons.flash_on,
    Icons.lock,
    Icons.park,
    Icons.baby_changing_station,
    Icons.nightlight_round,
    Icons.do_not_touch,
    Icons.accessibility_new,
    Icons.edit,
    Icons.flutter_dash,
    Icons.pets,
    Icons.question_mark,
    Icons.insert_emoticon,
    Icons.content_cut,
    Icons.person_off,
    Icons.ac_unit,
    Icons.snowing,
    Icons.bug_report,
    Icons.leak_add,
    Icons.sunny,
    Icons.hdr_weak,
    Icons.adjust,
    Icons.local_taxi,
    Icons.cyclone,
    Icons.queue_music,
    Icons.forest,
    Icons.water_drop,
    Icons.pets,
    Icons.change_circle,
    Icons.bedroom_baby
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
                child: getVerticalList(links, icons)),
          ],
        ),
        const Text(""),
      ],
    );
  }
}

// @param text: references or creators' names or images' links
// @return Container with vertical list references
ListView getVerticalList(List<String> text, List<IconData> icons) {
  return ListView(
      scrollDirection: Axis.vertical,
      children: List.generate(
        text.length,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(""),
              Icon(
                icons[index],
                size: SizeConfig.blockSizeVertical * 4,
              ),
              getTransparentFocusBox(
                  getText(text[index], SizeConfig.blockSizeHorizontal * 1.5,
                      Alignment.centerLeft),
                  SizeConfig.blockSizeVertical * 12,
                  SizeConfig.blockSizeHorizontal * 65),
              const Text(""),
            ],
          ),
        ),
      ));
}
