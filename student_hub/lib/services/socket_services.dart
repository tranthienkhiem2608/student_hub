import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static const String _socketUrl = 'https://api.studenthub.dev';

  IO.Socket connectSocket() {
    IO.Socket socket = IO.io(
        _socketUrl,
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .build());
    SharedPreferences.getInstance().then((prefs) {
      String token = prefs.getString('token')!;
      socket.io.options?['extraHeaders'] = {
        'Authorization': 'Bearer $token',
      };
      return socket;
    });
    return socket;
  }
}
