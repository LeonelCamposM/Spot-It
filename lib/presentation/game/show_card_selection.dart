import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/application/player/player_use_case.dart';
import 'package:spot_it_game/presentation/core/card_style.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/core/text_button_style.dart';
import 'package:spot_it_game/presentation/core/text_style.dart';
import 'package:spot_it_game/presentation/game/colors.dart';
import 'package:spot_it_game/infrastructure/players/player_repository.dart';

List<String> iconSelection = [];
const double pi = 3.1415926535897932;
bool changeContent = false;
String spotItResults = "";
String feedbackPhrase = "";

Future showCardSelection(
    context, SizedBox cardOne, SizedBox cardTwo, String roomID) {
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

  Future.delayed(const Duration(seconds: 8), () async {
    playerUseCase.spotIt(roomID, cardTwoInformation, cardOneInformation);
  });

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
              content: !changeContent
                  ? getDisplayedCards(context, setState, playerUseCase, roomID,
                      cardOneInformation, cardTwoInformation)
                  : getFeedback(context));
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
  bool response;
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
                          setState(() => {
                                //if both user icons are equals
                                if (iconSelection[0].split("%%")[1] ==
                                    iconSelection[1].split("%%")[1])
                                  {
                                    playerUseCase
                                        .spotIt(roomID, cardOneInformation,
                                            cardTwoInformation)
                                        .then((response) => {
                                              if (response == true)
                                                {
                                                  spotItResults =
                                                      "assets/logo.png",
                                                  feedbackPhrase = "Spot it!",
                                                }
                                              else
                                                {
                                                  spotItResults =
                                                      "assets/error.png",
                                                  feedbackPhrase =
                                                      "Le han hecho Spot It!",
                                                },
                                              changeContent = true,
                                            }),
                                  }
                                else
                                  {
                                    spotItResults = "assets/error.png",
                                    feedbackPhrase = "Iconos diferentes!",
                                    changeContent = true,
                                  },
                              })
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
                      changeContent = false,
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

Row getSelectedIcons(Function(void Function()) setState, String userNameCardOne,
    String userNameCardTwo) {
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

Column getFeedback(context) {
  return (Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          children: [
            SizedBox(
                height: SizeConfig.blockSizeHorizontal * 2,
                width: SizeConfig.blockSizeHorizontal * 7,
                child: const Text('')),
            FunkyFeedback(iconName: spotItResults),
            SizedBox(
                height: SizeConfig.blockSizeHorizontal * 2,
                width: SizeConfig.blockSizeHorizontal * 7,
                child: const Text('')),
          ],
        ),
      ),
      getText(
          feedbackPhrase, SizeConfig.blockSizeHorizontal * 3, Alignment.center),
      Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: getTextButton(
            "SALIR",
            SizeConfig.safeBlockHorizontal * 20,
            SizeConfig.safeBlockVertical * 10,
            SizeConfig.safeBlockHorizontal * 2,
            getSecondaryColor(),
            () => {
                  changeContent = false,
                  feedbackPhrase = "",
                  iconSelection.clear(),
                  Navigator.pop(context)
                }),
      )
    ],
  ));
}

// ignore: must_be_immutable
class FunkyFeedback extends StatefulWidget {
  String iconName;
  FunkyFeedback({Key? key, required this.iconName}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => FunkyFeedbackState(iconName: iconName);
}

class FunkyFeedbackState extends State<FunkyFeedback>
    with SingleTickerProviderStateMixin {
  FunkyFeedbackState({Key? key, required this.iconName});
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  String iconName;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat();
    scaleAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(controller);

    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Transform.rotate(
          angle: scaleAnimation.value,
          child: Container(
            decoration: ShapeDecoration(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Column(
              children: [
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 18,
                  height: SizeConfig.blockSizeHorizontal * 12,
                  child: Image(
                    image: AssetImage(iconName),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
