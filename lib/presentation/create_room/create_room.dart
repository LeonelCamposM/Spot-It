import 'package:flutter/material.dart';
import 'package:spot_it_game/domain/clients/client_service.dart';
import 'package:spot_it_game/presentation/core/button_style.dart';
import 'package:spot_it_game/presentation/core/focus_box.dart';
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

  List<IconData> userIcons = [
    Icons.account_circle,
    Icons.face,
    Icons.face_2,
    Icons.face_3,
    Icons.face_4,
    Icons.face_5,
    Icons.face_6,
    Icons.boy,
    Icons.girl
  ];

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
  final ButtonStyle style =
      getButtonStyle(650, 85, 30.0, const Color.fromARGB(255, 76, 7, 112));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getIconButtonStyle(
                    getSecondaryColor(),
                    IconButton(
                        iconSize: getIconSize(),
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                          );
                        }))
              ],
            )),
        getFocusBox(
            Column(children: [
              Flexible(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    getIconButtonStyle(
                        getSecondaryColor(),
                        IconButton(
                            iconSize: getIconSize(),
                            icon: const Icon(Icons.face),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                              );
                            })),
                  ],
                ),
              ),
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
                          child: getInputField("Ingrese su nombre", context)),
                      ElevatedButton(
                        style: style,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const WaitingRoomPage()),
                          );
                        },
                        child: getText("CREAR SALA", 25, Alignment.center),
                      )
                    ],
                  ),
                ),
              ),
            ]),
            600,
            800), //focus box
      ],
    );
  }
}
