import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

// main() {
//   // Dart client
//   IO.Socket socket = IO.io('http://localhost:3000');
//   socket.onConnect((_) {
//     print('connect');
//     socket.emit('msg', 'test');
//   });
//   socket.on('event', (data) => print(data));
//   socket.onDisconnect((_) => print('disconnect'));
//   socket.on('fromServer', (_) => print(_));
// }

class ChatProvider with ChangeNotifier {
  Socket? socket;

  initialize() {
    debugPrint("Socket initialize");

    var uri = Uri.parse('http://arzan.info:3020');
    debugPrint("socket port: ${uri.port}");

    Socket socket = io(
      'http://arzan.info:3020',
      // OptionBuilder().setTransports(['websocket']).build(),
    );

    socket.onConnectError((data) => debugPrint("on connect error $data"));
    socket.onError((data) => debugPrint("on error $data"));

    socket.onConnect((_) {
      debugPrint('Socket Connected!!!');
    });

    socket.onDisconnect((_) => debugPrint('Socket Disconnected!!!'));

    socket.connect();

    this.socket = socket;
  }
}
