import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spot_it_game/application/player/player_use_case.dart';
import 'package:spot_it_game/application/rooms/rooms_use_case.dart';
import 'package:spot_it_game/domain/players/player.dart';
import 'package:spot_it_game/domain/rooms/room.dart';
import 'package:spot_it_game/infrastructure/players/player_repository.dart';
import 'package:spot_it_game/infrastructure/rooms/rooms_repository.dart';
import 'package:spot_it_game/presentation/core/button_style.dart';
import 'package:spot_it_game/presentation/core/focus_box.dart';
import 'package:spot_it_game/presentation/core/get_children_with_icon.dart';
import 'package:spot_it_game/presentation/core/text_button_style.dart';
import 'package:spot_it_game/presentation/register_room/colors.dart';
import 'package:spot_it_game/presentation/waiting_room/waiting_room.dart';
import 'package:spot_it_game/presentation/home/home.dart';
import 'package:spot_it_game/presentation/core/input_field.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';

class RegisterRoomPage extends StatefulWidget {
  static String routeName = '/register_room';
  const RegisterRoomPage({Key? key}) : super(key: key);
  @override
  State<RegisterRoomPage> createState() => _RegisterRoomPageState();
}

class _RegisterRoomPageState extends State<RegisterRoomPage> {
  _RegisterRoomPageState() : isLoading = true;
  bool isLoading;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: getPrimaryColor(),
      body: const Padding(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: _RegisterRoomWidget(),
        ),
      ),
    );
  }
}

class _RegisterRoomWidget extends StatefulWidget {
  const _RegisterRoomWidget({Key? key}) : super(key: key);

  @override
  State<_RegisterRoomWidget> createState() => _RegisterRoomWidgetState();
}

class _RegisterRoomWidgetState extends State<_RegisterRoomWidget> {
  final ButtonStyle style = getButtonStyle(650, 85, 30.0, getSecondaryColor());

  RoomUseCase roomUseCase =
      RoomUseCase(RoomRepository(FirebaseFirestore.instance));

  PlayerUseCase playerUseCase =
      PlayerUseCase(PlayerRepository(FirebaseFirestore.instance));

  late String roomIDGuest;

  final textNameController = TextEditingController();
  final textRoomIDController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as RegisterRoomArgs;
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
                    Flexible(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              flex: 3,
                              // Double arrow back to get the previous icon
                              child: getButtonWithIcon(
                                  const Icon(Icons.keyboard_double_arrow_left),
                                  8.0,
                                  14.0,
                                  4.0),
                            ),
                            Flexible(
                              flex: 3,
                              //Icon for the user
                              child: getButtonWithIcon(
                                  const Icon(Icons.face), 12.0, 18.0, 6.0),
                            ),
                            Flexible(
                              flex: 3,
                              // Double arrow back to get the next icon
                              child: getButtonWithIcon(
                                  const Icon(Icons.keyboard_double_arrow_right),
                                  8,
                                  14.0,
                                  4.0),
                            ),
                          ],
                        )),
                    Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: SizeConfig.safeBlockVertical * 10,
                              width: SizeConfig.blockSizeHorizontal * 30,
                              child: getInputField(
                                  "Nombre", textNameController, context),
                            ),

                            args.isHost == false
                                ? SizedBox(
                                    width: SizeConfig.safeBlockHorizontal * 30,
                                    height: SizeConfig.safeBlockVertical * 10,
                                    child: getInputField("ID de sala",
                                        textRoomIDController, context),
                                  )
                                : const SizedBox(),
                            // Create Room Button
                            args.isHost == true
                                ? getTextButton(
                                    "CREAR SALA",
                                    SizeConfig.safeBlockHorizontal * 30,
                                    SizeConfig.safeBlockVertical * 10,
                                    SizeConfig.safeBlockHorizontal * 2,
                                    getSecondaryColor(), () async {
                                    String roomID = await roomUseCase
                                        .createRoom(Room(0, true));

                                    await playerUseCase.addPlayer(
                                        Player(textNameController.text, "Face",
                                            "Anchor,Apple,Bomb,Cactus,Carrot,Candle,Cheese,Chessknight", 1, 1),
                                        roomID);

                                    await playerUseCase.addPlayer(
                                        Player('Bot', "Bot", "Anchor,Apple,Bomb,Cactus,Carrot,Candle,Cheese,Chessknight", 1, 1), roomID);

                                    Navigator.pushNamed(
                                        context, WaitingRoomPage.routeName,
                                        arguments:
                                            WaitingRoomArgs(true, roomID));
                                  })
                                : getTextButton(
                                    "UNIRSE",
                                    SizeConfig.safeBlockHorizontal * 30,
                                    SizeConfig.safeBlockVertical * 10,
                                    SizeConfig.safeBlockHorizontal * 2,
                                    getSecondaryColor(), () async {
                                    await playerUseCase.addPlayer(
                                        Player(textNameController.text, "face",
                                            "", 1, 2),
                                        textRoomIDController.text);
                                    Navigator.pushNamed(
                                        context, WaitingRoomPage.routeName,
                                        arguments: WaitingRoomArgs(
                                            false, textRoomIDController.text));
                                  }),
                          ],
                        ),
                      ),
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

// @param newIcon: Icon for the button
// @param boxWidth: size for the box's width
// @param boxHeight: size fot the box's height
// @param sizeIcon: icon's size
// @return the button with the icon
SizedBox getButtonWithIcon(
    Icon newIcon, double boxWidth, double boxHeight, double sizeIcon) {
  return SizedBox(
    width: SizeConfig.safeBlockHorizontal * boxWidth,
    height: SizeConfig.safeBlockVertical * boxHeight,
    child: Card(
      elevation: 10,
      color: getSecondaryColor(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
      ),
      child: IconButton(
        iconSize: SizeConfig.safeBlockHorizontal * sizeIcon,
        icon: newIcon,
        onPressed: () {
          //
        },
      ),
    ),
  );
}

class WaitingRoomArgs {
  final bool isHost;
  final String roomID;
  WaitingRoomArgs(this.isHost, this.roomID);
}
