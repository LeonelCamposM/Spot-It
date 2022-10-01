import 'package:socket_io_client/socket_io_client.dart';
import 'package:spot_it_game/domain/clients/client.dart';

class ClientService {
  final _socketClient = Client.instance.socket!;
  Socket get socketClient => _socketClient;

  void emitCreateRoom(String userName) {
    if (userName.isNotEmpty) {
      _socketClient.emit('createRoom', {
        'userName': userName,
      });
    }
  }
}
