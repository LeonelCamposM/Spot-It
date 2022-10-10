import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/clients/client_service.dart';
import 'package:spot_it_game/presentation/core/button_style.dart';
import 'package:spot_it_game/presentation/core/focus_box.dart';
import 'package:spot_it_game/presentation/core/get_children_with_icon.dart';
import 'package:spot_it_game/presentation/core/icon_button_style.dart';
import 'package:spot_it_game/presentation/core/loading_widget.dart';
import 'package:spot_it_game/presentation/create_room/colors.dart';
import 'package:spot_it_game/presentation/waiting_room/waiting_room.dart';
import 'package:spot_it_game/presentation/home/home.dart';
import 'package:spot_it_game/presentation/core/input_field.dart';
import 'package:spot_it_game/presentation/core/text_style.dart';
import 'dart:math';

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
  }

  Future<void> addRoom() async {
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getPrimaryColor(),
      appBar: AppBar(
          title: const Text('Crear sala'),
          automaticallyImplyLeading: false,
          backgroundColor: getSecondaryColor()),
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
                getChildrenWithIcon(
                    context,
                    const Icon(Icons.arrow_back),
                    getSecondaryColor(),
                    MaterialPageRoute(builder: (context) => const HomePage())),
              ],
            )),
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
                              child: SizedBox(
                                width: 150,
                                height: 150,
                                child: Card(
                                  elevation: 10,
                                  color: getSecondaryColor(),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(35.0),
                                  ),
                                  child: IconButton(
                                    iconSize: 100.0,
                                    icon: const Icon(
                                        Icons.keyboard_double_arrow_left),
                                    onPressed: () {
                                      //
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: SizedBox(
                                width: 250,
                                height: 250,
                                child: Card(
                                  elevation: 10,
                                  color: getSecondaryColor(),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(35.0),
                                  ),
                                  child: IconButton(
                                    iconSize: 200.0,
                                    icon: const Icon(Icons.face),
                                    onPressed: () {
                                      //
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: SizedBox(
                                width: 150,
                                height: 150,
                                child: Card(
                                  elevation: 10,
                                  color: getSecondaryColor(),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(35.0),
                                  ),
                                  child: IconButton(
                                    iconSize: 100.0,
                                    icon: const Icon(
                                        Icons.keyboard_double_arrow_right),
                                    onPressed: () {
                                      //
                                    },
                                  ),
                                ),
                              ),
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
                                height: 70,
                                width: 610,
                                child: getInputField(
                                    "Ingrese su nombre", context)),
                            ElevatedButton(
                              style: style,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const WaitingRoomPage()),
                                );
                              },
                              child:
                                  getText("CREAR SALA", 25, Alignment.center),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
            600,
            800), //focus box
      ],
    );
  }
}
