import 'package:flutter/material.dart';
import 'package:spot_it_game/presentation/core/loading_widget.dart';

class WaitingRoomPage extends StatefulWidget {
  static String routeName = '/waiting_room';
  const WaitingRoomPage({Key? key}) : super(key: key);
  @override
  State<WaitingRoomPage> createState() => _WaitingRoomPageState();
}

class _WaitingRoomPageState extends State<WaitingRoomPage> {
  _WaitingRoomPageState() : isLoading = true;
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
      appBar: AppBar(title: const Text('Room')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: isLoading ? const LoadingWidget() : const Text('Room'),
        ),
      ),
    );
  }
}

// class _RoomWidget extends StatefulWidget {
//   const _RoomWidget({Key? key}) : super(key: key);
//   @override
//   State<_RoomWidget> createState() => _RoomWidgetState();
// }

// class _RoomWidgetState extends State<_RoomWidget> {
//   final ClientService clientService = ClientService();
//   final ButtonStyle style =
//       ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const SizedBox(height: 30),
//         ElevatedButton(
//           style: style,
//           onPressed: () => clientService.emitCreateRoom(
//             "user name",
//           ),
//           child: const Text('Crear sala'),
//         ),
//         const SizedBox(height: 30),
//         ElevatedButton(
//           style: style,
//           onPressed: () {},
//           child: const Text('Unirse a sala'),
//         ),
//       ],
//     );
//   }
// }
