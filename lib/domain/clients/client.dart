import 'package:socket_io_client/socket_io_client.dart' as socket_io;

class Client {
  socket_io.Socket? socket;
  static Client? _instance;

  Client._internal() {
    socket = socket_io.io('http://127.0.0.1:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket!.connect();
  }

  static Client get instance {
    _instance ??= Client._internal();
    return _instance!;
  }
}
