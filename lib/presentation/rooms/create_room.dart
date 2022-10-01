import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_it_game/application/rooms/rooms_use_case.dart';
import 'package:spot_it_game/domain/clients/client_service.dart';
import 'package:spot_it_game/domain/rooms/room.dart';
import 'package:spot_it_game/presentation/core/loading_widget.dart';
import '../../infrastructure/rooms/rooms_repository.dart';

class RoomPage extends StatefulWidget {
  static String routeName = '/';
  const RoomPage({Key? key}) : super(key: key);

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  _RoomPageState() : isLoading = true;
  final _roomUseCase = RoomUseCase(RoomRepository(FirebaseFirestore.instance));
  bool isLoading;

  @override
  void initState() {
    super.initState();
    addRoom();
  }

  Future<void> addRoom() async {
    Room newRoom = Room("leonel", true);
    await _roomUseCase.createRoom(newRoom);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Room')),
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
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 30),
        ElevatedButton(
          style: style,
          onPressed: () => clientService.emitCreateRoom(
            "user name",
          ),
          child: const Text('Crear sala'),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          style: style,
          onPressed: () {},
          child: const Text('Unirse a sala'),
        ),
      ],
    );
  }
}
