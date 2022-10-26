import 'package:flutter/material.dart';
import 'package:spot_it_game/presentation/core/card_style.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/core/text_button_style.dart';
import 'package:spot_it_game/presentation/core/text_style.dart';
import 'package:spot_it_game/presentation/game/colors.dart';

List<String> cardSelection = [];
const double pi = 3.1415926535897932;

Future showCardSelection(context, SizedBox cardOne, SizedBox cardTwo) {
  bool changeContent = false;
  String spotItResults = "";
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

  String userNameCardOne = cardOneInformation[0];
  String userNameCardTwo = cardTwoInformation[0];
  List<String> currentUserCard = cardOneInformation[1].split(",");
  List<String> otherUserCard = cardTwoInformation[1].split(",");

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
                  ? Column(
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
                                    child: getCardStylePopUp(
                                        setState,
                                        userNameCardOne,
                                        currentUserCard,
                                        10,
                                        10),
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
                                    child: getCardStylePopUp(setState,
                                        userNameCardTwo, otherUserCard, 10, 10),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 5,
                                height: SizeConfig.blockSizeHorizontal * 5,
                                child: cardSelection.isNotEmpty
                                    ? getSingleCardIconPopUp(
                                        setState,
                                        userNameCardOne,
                                        cardSelection[0].split("%%")[1])
                                    : const Text(" "),
                              ),
                              const Text("  "),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 5,
                                height: SizeConfig.blockSizeHorizontal * 5,
                                child: cardSelection.length == 2
                                    ? getSingleCardIconPopUp(
                                        setState,
                                        userNameCardTwo,
                                        cardSelection[1].split("%%")[1])
                                    : const Text(" "),
                              )
                            ],
                          ),
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
                                  cardSelection.length == 2
                                      ? () => {
                                            setState(() => {
                                                  //if both user icons are equals
                                                  if (cardSelection[0]
                                                          .split("%%")[1] ==
                                                      cardSelection[1]
                                                          .split("%%")[1])
                                                    {
                                                      spotItResults =
                                                          'assets/logo.png',
                                                    }
                                                  else
                                                    {
                                                      spotItResults =
                                                          'assets/error.png',
                                                    },
                                                  changeContent = true,
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
                                        cardSelection.clear(),
                                        Navigator.pop(context)
                                      })
                            ],
                          ),
                        ]),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            children: [
                              SizedBox(
                                  height: SizeConfig.blockSizeHorizontal * 5,
                                  width: SizeConfig.blockSizeHorizontal * 10,
                                  child: const Text('')),
                              FunkyFeedback(iconName: spotItResults),
                              SizedBox(
                                  height: SizeConfig.blockSizeHorizontal * 5,
                                  width: SizeConfig.blockSizeHorizontal * 10,
                                  child: const Text('')),
                            ],
                          ),
                        ),
                        getText(
                            spotItResults.contains("error")
                                ? "Intentelo de nuevo!"
                                : "Spot It!",
                            SizeConfig.blockSizeHorizontal * 3,
                            Alignment.center),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: getTextButton(
                              "SALIR",
                              SizeConfig.safeBlockHorizontal * 20,
                              SizeConfig.safeBlockVertical * 10,
                              SizeConfig.safeBlockHorizontal * 2,
                              getSecondaryColor(),
                              () => {
                                    cardSelection.clear(),
                                    Navigator.pop(context)
                                  }),
                        )
                      ],
                    ));
        },
      );
    },
  );
}

class FunkyFeedback extends StatefulWidget {
  String iconName;
  FunkyFeedback({Key? key, required this.iconName}) : super(key: key);

  @override
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

SizedBox getCardStylePopUp(Function(void Function()) setState, String userName,
    List<String> card, int width, int height) {
  var cardBackgroundColor = const Color.fromARGB(255, 255, 255, 255);
  var cardBorderColor = Colors.black;
  return SizedBox(
      width: SizeConfig.safeBlockHorizontal * width,
      height: SizeConfig.safeBlockHorizontal * height,
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: cardBorderColor,
                width: 3,
              ),
              color: cardBackgroundColor,
              shape: BoxShape.circle),
          child: Column(
            children: [
              getSingleCardIconPopUp(setState, userName, card[0]),
              getDoubleCardIconPopUp(setState, userName, card[1], card[2]),
              getDoubleCardIconPopUp(setState, userName, card[3], card[4]),
              getDoubleCardIconPopUp(setState, userName, card[5], card[6]),
              getSingleCardIconPopUp(setState, userName, card[7])
            ],
          )));
}

// @return returns a Flexible with 2 rendered icons
// @param card: CardData with all cards icons
// @param iconOne: name of icon to be rendered
// @param showButtonCard: whether to show icons as buttons or no
Flexible getDoubleCardIconPopUp(Function(void Function()) setState,
    String userName, String iconNameOne, String iconNameTwo) {
  return Flexible(
      flex: 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          getSingleCardIconPopUp(setState, userName, iconNameOne),
          getSingleCardIconPopUp(setState, userName, iconNameTwo)
        ],
      ));
}

// @return returns a Flexible with rendered icon
// @param card: CardData with all cards icons
// @param iconName: name of icon to be rendered
// @param showButtonCard: whether to show icons as buttons or no
SizedBox getSingleCardIconPopUp(
    Function(void Function()) setState, userName, String iconName) {
  return SizedBox(
    height: SizeConfig.blockSizeHorizontal * 7,
    width: SizeConfig.blockSizeHorizontal * 7,
    child: ElevatedButton(
      child: Container(
        child: getIcon(iconName),
      ),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        primary: Colors.white,
      ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
      onPressed: () => setState(() => {
            if (cardSelection.isEmpty)
              {
                cardSelection.add(userName + "%%" + iconName),
              }
            else if (cardSelection.length < 2)
              {
                if (cardSelection[0] != userName + "%%" + iconName)
                  cardSelection.add(userName + "%%" + iconName),
              }
            else if (cardSelection.length >= 2)
              {
                cardSelection.clear(),
                cardSelection.add(userName + "%%" + iconName),
              },
          }),
    ),
  );
}
