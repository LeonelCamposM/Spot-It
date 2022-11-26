import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/application/player/player_use_case.dart';
import 'package:spot_it_game/domain/players/player.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/core/text_button_style.dart';
import 'package:spot_it_game/presentation/core/text_style.dart';
import 'package:spot_it_game/presentation/game/colors.dart';
import 'package:spot_it_game/presentation/game/show_card_selection.dart';

// ignore: must_be_immutable
class OnSpotIt extends StatelessWidget {
  String roomID;
  late Stream<QuerySnapshot> _usersStream;
  List<String> cardOneInformation;
  List<String> cardTwoInformation;
  PlayerUseCase playerUseCase;
  Function(void Function()) setState;
  bool isHost;
  String nickname;
  OnSpotIt(
      {Key? key,
      required this.roomID,
      required this.setState,
      required this.cardOneInformation,
      required this.cardTwoInformation,
      required this.playerUseCase,
      required this.isHost,
      required this.nickname})
      : super(key: key) {
    _usersStream = FirebaseFirestore.instance
        .collection('/Room_Player/' + roomID + '/players')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('');
        }

        List<Player> players = getAllPlayers(snapshot);

        Player currentUser =
            players.firstWhere(((element) => element.nickname == nickname));

        if (currentUser.cardCount == -1) {
          return getFeedback(context, 'assets/logo.png',
              'El juego ha terminado!', roomID, nickname);
        }

        bool madeSpotit = currentUser.displayedCard.contains("SpotItLogo,SpotItLogo") &&
            currentUser.cardCount == 0;
        if (madeSpotit) {
          return getFeedback(
              context, 'assets/logo.png', '¡Spot it!', roomID, nickname);
        }

        bool spoted = currentUser.cardCount == 2;
        if (spoted) {
          return getFeedback(context, 'assets/error.png',
              'Le hicieron spot it!', roomID, nickname);
        }

        for (var element in players) {
          if (element.nickname == cardOneInformation[0]) {
            cardOneInformation[1] = element.displayedCard;
          }
          if (element.nickname == cardTwoInformation[0]) {
            if (element.displayedCard != cardTwoInformation[1] &&
                element.cardCount == 2) {
              return getFeedback(
                  context,
                  'assets/error.png',
                  "a " + element.nickname + ' le hicieron spot it!',
                  roomID,
                  nickname);
            }
            cardTwoInformation[1] = element.displayedCard;
            if (element.displayedCard.contains("SpotItLogo,SpotItLogo")) {
              return getFeedback(context, 'assets/error.png',
                  " " + element.nickname + ' hizo spot it!', roomID, nickname);
            }
          }
        }
        return CardSelector(
          currentPlayerCardInf: cardOneInformation,
          otherPlayerCardInf: cardTwoInformation,
          roomID: roomID,
        );
      },
    );
  }
}

Column getFeedback(
  context,
  String spotItResults,
  String feedbackPhrase,
  String roomID,
  String nickname,
) {
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
      'El juego ha terminado!' == feedbackPhrase
          ? Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: getTextButton(
                  "SALIR",
                  SizeConfig.safeBlockHorizontal * 20,
                  SizeConfig.safeBlockVertical * 10,
                  SizeConfig.safeBlockHorizontal * 2,
                  getSecondaryColor(),
                  () => {Navigator.pop(context)}))
          : Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: getTextButton(
                  "SALIR",
                  SizeConfig.safeBlockHorizontal * 20,
                  SizeConfig.safeBlockVertical * 10,
                  SizeConfig.safeBlockHorizontal * 2,
                  getSecondaryColor(),
                  () => {
                        updateCardCount(roomID, nickname),
                        Navigator.pop(context)
                      }),
            )
    ],
  ));
}

void updateCardCount(String roomID, String nickname) async {
  var playersReference = FirebaseFirestore.instance
      .collection('Room_Player')
      .doc(roomID)
      .collection('players');
  var players = await playersReference.get();
  var currentPlayer = players.docs
      .where((element) => element.data()['nickname'] == nickname)
      .first;

  var currentPlayerReference = playersReference.doc(currentPlayer.id);
  Player newPlayer = Player.fromJson(currentPlayer.data());
  newPlayer.cardCount = 1;
  currentPlayerReference.update(newPlayer.toJson());
}

// @param snapshot: enventListener on database
// @return updated player on db
List<Player> getAllPlayers(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
  // Get all chat messages from snapshot
  List<Player> messages = [];
  ListView(
    children: snapshot.data!.docs
        .map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          messages.add(Player.fromJson(data));
        })
        .toList()
        .cast(),
  );

  return messages;
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
