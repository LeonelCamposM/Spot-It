import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/application/player/player_use_case.dart';
import 'package:spot_it_game/infrastructure/players/eventListeners/on_spot_it.dart';
import 'package:spot_it_game/presentation/core/card_style.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/core/text_button_style.dart';
import 'package:spot_it_game/presentation/core/text_style.dart';
import 'package:spot_it_game/presentation/game/colors.dart';
import 'package:spot_it_game/infrastructure/players/player_repository.dart';

const double pi = 3.1415926535897932;
bool changeContent = false;
String spotItResults = "";
String feedbackPhrase = "";

Future showCardSelection(context, SizedBox cardOne, SizedBox cardTwo,
    String roomID, bool isHost, String nickname) {
  spotItResults = "";
  feedbackPhrase = "";

  //Information (userName and card) about the current user card and the selected card by user
  List<String> cardOneInformation = cardOne.key
      .toString()
      .replaceAll("[<", "")
      .replaceAll(">]", "")
      .replaceAll("'", "")
      .split("%%");
  List<String> cardTwoInformation = cardTwo.key
      .toString()
      .replaceAll("[<", "")
      .replaceAll(">]", "")
      .replaceAll("'", "")
      .split("%%");

  PlayerUseCase playerUseCase =
      PlayerUseCase(PlayerRepository(FirebaseFirestore.instance));

  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
              contentPadding: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              backgroundColor: getPrimaryColor(),
              content: SizedBox(
                  child: OnSpotIt(
                isHost: isHost,
                roomID: roomID,
                setState: setState,
                playerUseCase: playerUseCase,
                cardOneInformation: cardOneInformation,
                cardTwoInformation: cardTwoInformation,
                nickname: nickname,
              )));
        },
      );
    },
  );
}

// ignore: must_be_immutable
class CardSelector extends StatefulWidget {
  late List<String> currentPlayerCardInf;
  late List<String> otherPlayerCardInf;
  late String roomID;

  CardSelector(
      {Key? key,
      required this.currentPlayerCardInf,
      required this.otherPlayerCardInf,
      required this.roomID})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CardSelectorState();
}

class _CardSelectorState extends State<CardSelector> {
  List<String> currentUserCard = [];
  List<String> otherUserCard = [];
  String userNameCardOne = "";
  String userNameCardTwo = "";
  String selectedIconOne = "SpotItLogo";
  String selectedIconTwo = "SpotItLogo";
  bool differentIcons = false;

  PlayerUseCase playerUseCase =
      PlayerUseCase(PlayerRepository(FirebaseFirestore.instance));

  callback(String route, String state) {
    setState(() {
      if (route == "one") {
        selectedIconOne = state;
      }
      if (route == "two") {
        selectedIconTwo = state;
      }
      if (route == "different") {
        differentIcons = !differentIcons;
      }
    });
  }

  @override
  void initState() {
    currentUserCard = widget.currentPlayerCardInf[1].split(",");
    otherUserCard = widget.otherPlayerCardInf[1].split(",");
    userNameCardOne = widget.currentPlayerCardInf[0];
    userNameCardTwo = widget.otherPlayerCardInf[0];
    differentIcons = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              getText(userNameCardOne, 25, Alignment.center),
              SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 25,
                  height: SizeConfig.blockSizeHorizontal * 25,
                  child: CardStylePopUp(callback, selectedIconOne, "one",
                      userNameCardOne, currentUserCard)),
            ],
          ),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 2,
            height: SizeConfig.blockSizeHorizontal * 2,
            child: const Text(""),
          ),
          Column(
            children: [
              getText(userNameCardTwo, 25, Alignment.center),
              SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 25,
                  height: SizeConfig.blockSizeHorizontal * 25,
                  child: CardStylePopUp(callback, selectedIconTwo, "two",
                      userNameCardTwo, otherUserCard)),
            ],
          ),
        ],
      ),
      !differentIcons
          ? const SizedBox()
          : getText("Iconos diferentes!", SizeConfig.blockSizeHorizontal * 2,
              Alignment.center),
      SizedBox(
        width: SizeConfig.blockSizeHorizontal * 2,
        height: SizeConfig.blockSizeHorizontal * 2,
        child: const Text(""),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getTextButton(
              "SPOT IT!",
              SizeConfig.safeBlockHorizontal * 20,
              SizeConfig.safeBlockVertical * 10,
              SizeConfig.safeBlockHorizontal * 2,
              getSecondaryColor(),
              !selectedIconOne.contains("SpotItLogo") &&
                      !selectedIconTwo.contains("SpotItLogo")
                  ? () => {
                        //if both user icons are equals
                        if (selectedIconOne == selectedIconTwo)
                          {
                            playerUseCase.spotIt(
                                widget.roomID,
                                widget.currentPlayerCardInf,
                                widget.otherPlayerCardInf)
                          }
                        else
                          {
                            callback("different", ""),
                            Future.delayed(const Duration(seconds: 3), () {
                              callback("different", "");
                            }),
                          },
                        callback("one", "SpotItLogo"),
                        callback("two", "SpotItLogo"),
                      }
                  : null),
          const Text("  "),
          getTextButton(
              "CANCELAR",
              SizeConfig.safeBlockHorizontal * 20,
              SizeConfig.safeBlockVertical * 10,
              SizeConfig.safeBlockHorizontal * 2,
              getSecondaryColor(),
              () => {
                    feedbackPhrase = "",
                    callback("one", "SpotItLogo"),
                    callback("two", "SpotItLogo"),
                    Navigator.pop(context)
                  })
        ],
      ),
    ]);
  }
}

// ignore: must_be_immutable
class CardStylePopUp extends StatefulWidget {
  final Function callbackFunction;
  String userName;
  String route;
  List<String> card;
  String selectedIcon;

  CardStylePopUp(this.callbackFunction, this.selectedIcon, this.route,
      this.userName, this.card,
      {Key? key})
      : super(key: key);

  @override
  State<CardStylePopUp> createState() => _CardStylePopUpState();
}

class _CardStylePopUpState extends State<CardStylePopUp> {
  var cardBackgroundColor = const Color.fromARGB(255, 255, 255, 255);

  var cardBorderColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: SizeConfig.blockSizeHorizontal * 25,
          height: SizeConfig.blockSizeHorizontal * 25,
          child: getCardStylePopUp(widget.callbackFunction, widget.selectedIcon,
              widget.route, widget.userName, widget.card, 10, 10),
        ),
      ],
    );
  }
}
