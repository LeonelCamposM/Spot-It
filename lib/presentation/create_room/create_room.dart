import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spot_it_game/domain/clients/client_service.dart';
import 'package:spot_it_game/presentation/core/button_style.dart';
import 'package:spot_it_game/presentation/core/focus_box.dart';
import 'package:spot_it_game/presentation/core/get_children_with_icon.dart';
import 'package:spot_it_game/presentation/core/loading_widget.dart';
import 'package:spot_it_game/presentation/create_room/colors.dart';
import 'package:spot_it_game/presentation/waiting_room/waiting_room.dart';
import 'package:spot_it_game/presentation/home/home.dart';
import 'package:spot_it_game/presentation/core/input_field.dart';
import 'package:spot_it_game/presentation/core/size_config.dart';

import '../core/text_button_style.dart';

class HostCreateRoomPage extends StatefulWidget {
  static String routeName = '/create_room';
  const HostCreateRoomPage({Key? key}) : super(key: key);
  @override
  State<HostCreateRoomPage> createState() => _HostCreateRoomPageState();
}

class _HostCreateRoomPageState extends State<HostCreateRoomPage> {
  _HostCreateRoomPageState() : isLoading = true;
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
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: isLoading ? const LoadingWidget() : const _RoomWidget(),
        ),
      ),
    );
  }
}

class _RoomWidget extends StatefulWidget {
  const _RoomWidget({Key? key}) : super(key: key);

  @override
  State<_RoomWidget> createState() => _RoomWidgetState();
}

class _RoomWidgetState extends State<_RoomWidget> {
  final ClientService clientService = ClientService();
  final ButtonStyle style = getButtonStyle(650, 85, 30.0, getSecondaryColor());

  @override
  Widget build(BuildContext context) {
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
                              height: SizeConfig.safeBlockVertical * 8,
                              width: SizeConfig.safeBlockHorizontal * 31,
                              child:
                                  getInputField("Ingrese su nombre", context),
                            ),
                            // Create Room Button
                            getTextButton(
                                "CREAR SALA",
                                SizeConfig.safeBlockHorizontal * 31,
                                SizeConfig.safeBlockVertical * 9,
                                SizeConfig.safeBlockHorizontal * 2,
                                getSecondaryColor(),
                                const WaitingRoomPage(),
                                context),
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
Container getButtonWithIcon(
    Icon newIcon, double boxWidth, double boxHeight, double sizeIcon) {
  return Container(
      child: SizedBox(
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
  ));
}