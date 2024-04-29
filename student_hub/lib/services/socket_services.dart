import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static const String _socketUrl = 'https://api.studenthub.dev';
  late IO.Socket _socket;

  static IO.Socket builderSocket() {
    return IO.io(
      _socketUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );
  }

  void addAuthorizationToSocket() {
    SharedPreferences.getInstance().then((prefs) {
      String token = prefs.getString('token')!;
      print("Token: $token");
      _socket.io.options?['extraHeaders'] = {
        'Authorization': 'Bearer  $token',
      };
    });
  }

  void sendMessage(var message) {
    print("Message: $message");
    _socket.emit('SEND_MESSAGE', message);
  }

  void receiveMessage() {
    _socket.on('RECEIVE_MESSAGE', (data) {
      print("Content: $data");
    });
  }

  static void disconnectSocket({required IO.Socket socket}) {
    socket.disconnect();
  }

  SocketService() {
    _socket = builderSocket();
    addAuthorizationToSocket();
    _socket.connect();
    _socket.onConnect((data) {
      print('Connected');
    });
    // _socket.onConnectError((data) => print('$data'));
    // _socket.onError((data) => print(data));
    receiveMessage();
  }
}
