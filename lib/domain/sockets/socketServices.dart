import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:spot_it_game/domain/sockets/socket.dart';
import 'package:spot_it_game/presentation/game/game.dart';

class SocketService {
  final _socketClient = LocalSocket.instance.socket!;
  Socket get socketClient => _socketClient;

  void sendOnJoinableUpdate(String room) {
    print("enviado");
    _socketClient.emit('onJoinableUpdate', (room) {});
  }

  void recieveOnJoinableUpdate(BuildContext context) {
    print("prendido");
    _socketClient.on('onJoinableUpdate', (room) {
      print("recibido");
      Navigator.pushNamed(context, GamePage.routeName);
    });
  }
}
