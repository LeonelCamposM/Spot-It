import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/application/player/player_use_case.dart';
import 'package:spot_it_game/infrastructure/players/eventListeners/on_spot_it.dart';
import 'package:spot_it_game/presentation/core/card_style.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/core/text_button_style.dart';
import 'package:spot_it_game/presentation/game/colors.dart';
import 'package:spot_it_game/infrastructure/players/player_repository.dart';

List<String> iconSelection = [];
const double pi = 3.1415926535897932;
bool changeContent = false;
String spotItResults = "";
String feedbackPhrase = "";

Future showCardSelection(context, SizedBox cardOne, SizedBox cardTwo,
    String roomID, bool isHost, String nickname) {
  iconSelection.clear();
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

Column getDisplayedCards(
    context,
    Function(void Function()) setState,
    PlayerUseCase playerUseCase,
    String roomID,
    List<String> cardOneInformation,
    List<String> cardTwoInformation) {
  String userNameCardOne = cardOneInformation[0];
  String userNameCardTwo = cardTwoInformation[0];
  List<String> currentUserCard = cardOneInformation[1].split(",");
  List<String> otherUserCard = cardTwoInformation[1].split(",");
  return (Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(children: [
        Row(
          children: [
            Column(
              children: [
                Text(
                  userNameCardOne,
                  style: const TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 25,
                  height: SizeConfig.blockSizeHorizontal * 25,
                  child: getCardStylePopUp(setState, iconSelection,
                      userNameCardOne, currentUserCard, 10, 10),
                ),
              ],
            ),
            const Text("  "),
            Column(
              children: [
                Text(
                  userNameCardTwo,
                  style: const TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 25,
                  height: SizeConfig.blockSizeHorizontal * 25,
                  child: getCardStylePopUp(setState, iconSelection,
                      userNameCardTwo, otherUserCard, 10, 10),
                ),
              ],
            ),
          ],
        ),
        getSelectedIcons(setState, userNameCardOne, userNameCardTwo),
        const Text("  "),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getTextButton(
                "SPOT IT!",
                SizeConfig.safeBlockHorizontal * 20,
                SizeConfig.safeBlockVertical * 10,
                SizeConfig.safeBlockHorizontal * 2,
                getSecondaryColor(),
                iconSelection.length == 2
                    ? () => {
                          //if both user icons are equals
                          if (iconSelection[0].split("%%")[1] ==
                              iconSelection[1].split("%%")[1])
                            {
                              playerUseCase.spotIt(roomID, cardOneInformation,
                                  cardTwoInformation)
                            }
                          else
                            {
                              spotItResults = "assets/error.png",
                              feedbackPhrase = "Iconos diferentes!",
                            },
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
                      iconSelection.clear(),
                      Navigator.pop(context)
                    })
          ],
        ),
      ]),
    ],
  ));
}

Row getSelectedIcons(
    dynamic setState, String userNameCardOne, String userNameCardTwo) {
  return (Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: SizeConfig.blockSizeHorizontal * 5,
        height: SizeConfig.blockSizeHorizontal * 5,
        child: iconSelection.isNotEmpty
            ? getSingleCardIconPopUp(setState, iconSelection, userNameCardOne,
                iconSelection[0].split("%%")[1])
            : const Text(" "),
      ),
      const Text("  "),
      SizedBox(
        width: SizeConfig.blockSizeHorizontal * 5,
        height: SizeConfig.blockSizeHorizontal * 5,
        child: iconSelection.length == 2
            ? getSingleCardIconPopUp(setState, iconSelection, userNameCardTwo,
                iconSelection[1].split("%%")[1])
            : const Text(" "),
      )
    ],
  ));
}

// ignore: must_be_immutable
class CardSelector extends StatefulWidget {
  late List<String> currentPlayerCardInf;
  late List<String> otherPlayerCardInf;

  CardSelector(
      {Key? key,
      required this.currentPlayerCardInf,
      required this.otherPlayerCardInf})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CardSelectorState();
}

class _CardSelectorState extends State<CardSelector> {
  List<String> currentUserCard = [];
  List<String> otherUserCard = [];
  String userNameCardOne = "";
  String userNameCardTwo = "";
  String selectedIconOne = "";
  String selectedIconTwo = "";

  callback(String route, String state) {
    print(route + " " + state);
    setState(() {
      if (route == "one") {
        selectedIconOne = state;
      }
      if (route == "two") {
        selectedIconTwo = state;
      }
    });
  }

  @override
  void initState() {
    currentUserCard = widget.currentPlayerCardInf[1].split(",");
    otherUserCard = widget.otherPlayerCardInf[1].split(",");
    userNameCardOne = widget.currentPlayerCardInf[0];
    userNameCardTwo = widget.otherPlayerCardInf[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(children: [
          Row(
            children: [
              Column(
                children: [
                  Text(
                    userNameCardOne,
                    style: const TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 25,
                      height: SizeConfig.blockSizeHorizontal * 25,
                      child: CardStylePopUp(
                          callback, userNameCardOne, currentUserCard)),
                  Text("Selected icon one:" + selectedIconOne)
                ],
              ),
            ],
          ),
        ]),
      ],
    );
  }
}

// ignore: must_be_immutable
class CardStylePopUp extends StatefulWidget {
  final Function callbackFunction;
  String userName;
  List<String> card;

  CardStylePopUp(this.callbackFunction, this.userName, this.card, {Key? key})
      : super(key: key);

  @override
  State<CardStylePopUp> createState() => _CardStylePopUpState();
}

class _CardStylePopUpState extends State<CardStylePopUp> {
  var cardBackgroundColor = const Color.fromARGB(255, 255, 255, 255);

  var cardBorderColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getSingleCardIconPopUp2(widget.callbackFunction, iconSelection,
            widget.userName, widget.card[7]),
        getSingleCardIconPopUp2(widget.callbackFunction, iconSelection,
            widget.userName, widget.card[7]),
        getSingleCardIconPopUp2(widget.callbackFunction, iconSelection,
            widget.userName, widget.card[7]),
      ],
    );
  }
}

SizedBox getSingleCardIconPopUp2(
    setState, List<String> iconSelection, userName, String iconName) {
  return SizedBox(
    height: SizeConfig.blockSizeHorizontal * 7,
    width: SizeConfig.blockSizeHorizontal * 7,
    child: ElevatedButton(
      child: Container(
        child: getIcon(iconName),
      ),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        // ignore: deprecated_member_use
        primary: Colors.white,
      ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
      onPressed: () => {setState("one", iconName)},
    ),
  );
}
