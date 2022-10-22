import 'package:socket_io_client/socket_io_client.dart' as socket_io;

class LocalSocket {
  socket_io.Socket? socket;
  static LocalSocket? _instance;

  LocalSocket._internal() {
    socket = socket_io.io('https://127.0.0.1:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket!.connect();
    socket?.onConnect((_) {
      print('Connection established');
    });
  }

  static LocalSocket get instance {
    _instance ??= LocalSocket._internal();
    return _instance!;
  }
}
