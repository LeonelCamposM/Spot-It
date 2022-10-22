import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spot_it_game/presentation/core/focus_box.dart';
import 'package:spot_it_game/presentation/core/get_children_with_icon.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';
import 'package:spot_it_game/presentation/core/text_button_style.dart';
import 'package:spot_it_game/presentation/core/text_style.dart';
import 'package:spot_it_game/presentation/register_room/register_room.dart';
import 'package:spot_it_game/presentation/home/colors.dart';
import 'package:spot_it_game/presentation/credits/credits.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _RoomPageState();
}

class _RoomPageState extends State<HomePage> {
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(""),
            getFocusBox(
                Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 20,
                          height: SizeConfig.blockSizeHorizontal * 18,
                          child: const Image(
                            image: AssetImage('assets/logo.png'),
                          ),
                        ),
                        getText("Spot it!", SizeConfig.blockSizeHorizontal * 3,
                            Alignment.center),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        getTextButton(
                            "ANFITRIÓN",
                            SizeConfig.safeBlockHorizontal * 30,
                            SizeConfig.safeBlockVertical * 10,
                            SizeConfig.safeBlockHorizontal * 2,
                            getSecondaryColor(), () {
                          Navigator.pushNamed(
                              context, RegisterRoomPage.routeName,
                              arguments: RegisterRoomArgs(true));
                        }),
                        const Text(""),
                        getTextButton(
                            "INVITADO",
                            SizeConfig.safeBlockHorizontal * 30,
                            SizeConfig.safeBlockVertical * 10,
                            SizeConfig.safeBlockHorizontal * 2,
                            getSecondaryColor(), () {
                          Navigator.pushNamed(
                              context, RegisterRoomPage.routeName,
                              arguments: RegisterRoomArgs(false));
                        }),
                      ],
                    ),
                  ],
                ),
                SizeConfig.safeBlockVertical * 85,
                SizeConfig.safeBlockHorizontal * 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                getChildrenWithIcon(
                    context,
                    const Icon(Icons.receipt),
                    getSecondaryColor(),
                    MaterialPageRoute(
                        builder: (context) => const CreditsPage()))
              ],
            ),
          ],
        )),
      ),
    );
  }
}

class RegisterRoomArgs {
  final bool isHost;
  RegisterRoomArgs(this.isHost);
}
