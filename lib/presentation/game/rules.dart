import 'package:flutter/material.dart';
import 'package:spot_it_game/presentation/core/focus_box.dart';
import 'package:spot_it_game/presentation/core/icon_button_style.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/core/text_style.dart';

IconButton openRules(context, Color secondaryColor, Color primaryColor) {
  // Rules of the game
  List<String> rules = [
    "Se juega con un máximo de 8 jugadores y un mínimo de 2.",
    "Se tienen establecidas 5 rondas por partida.",
    "Se gana el juego cuando la persona es la más rápida en quedarse sin cartas en las rondas establecidas.",
    "Cuando la ronda inicia todos los jugadores voltean su primer carta al mismo tiempo.",
    "El jugador que encuentre dentro de su carta un dibujo que sea igual al de otro jugador le pasa la carta a este jugador.",
    "Si un jugador tiene más de una carta, entonces juega con la última que le pasaron.",
    "Cuando un jugador tiene más de una carta y va a pasarlas a otro jugador, entonces le pasa toda su pila de cartas",
    "En caso de empate, se realiza una ronda con las personas que quedaron sin cartas hasta que alguien gana."
  ];

  return IconButton(
    iconSize: getIconSize(),
    onPressed: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              backgroundColor: primaryColor,
              content: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // close button
                  Flexible(
                    flex: 4,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: getFocusBox(
                              getVerticalList(rules),
                              SizeConfig.blockSizeVertical * 85,
                              SizeConfig.blockSizeHorizontal * 50),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            getCloseButton(secondaryColor, context),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
    },
    icon: const Icon(Icons.question_mark_rounded),
  );
}

// @param secondaryColor: Current page secondary color
// @param context: build context
// @return Row with close button aligned to right
Row getCloseButton(Color secondaryColor, context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: getIconButtonStyle(
            secondaryColor,
            IconButton(
              iconSize: getIconSize(),
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
      ),
    ],
  );
}

// @param rules: List of all the rules of the game
// @return Container with vertical list of the rules
ListView getVerticalList(List<String> rules) {
  return ListView(
      scrollDirection: Axis.vertical,
      children: List.generate(
        rules.length,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getTransparentFocusBox(
                  getText(
                      (index + 1).toString() + ". " + rules[index],
                      SizeConfig.blockSizeHorizontal * 1.5,
                      Alignment.centerLeft),
                  SizeConfig.blockSizeVertical * 11,
                  SizeConfig.blockSizeHorizontal * 43)
            ],
          ),
        ),
      ));
}

Container getTransparentFocusBox(Widget widget, double height, double width) {
  return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
          color: Color.fromARGB(0, 0, 0, 0),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(40.0))),
      child: widget);
}
