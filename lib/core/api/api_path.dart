import 'dart:async';
import 'dart:io';

class ApiPath {
  // static String host = "192.168.110.215:8788";
  static List<String> availableHosts = [
    // "arzan.info",
    "217.174.238.236:3020",
  ];

  static String userToken = "";
  static String host = "";
  static String httpsPath = "http://" + host;

  static get imageUrl => httpsPath + "/api";

  static String authLogin = "/api/v1/login";
  static String authRegister = "/api/v1/register";
  static String authUserChecker = "/api/v1/user-checker";
  static String authGetSmsData = "/api/v1/sms-data";
  static String authRecoverPassword = "/api/v1/recover-password";

  static String getAccount = "/api/v1/users/";

  static String getPosts = "/api/v1/posts";
  static String createPost = "/api/v1/posts";

  static String getUsers = "/api/v1/users";

  static String getBanners = "/api/v1/banners";

  static String getNotifications = "/api/v1/notifications";

  static String userActions = "/api/v1/user-actions";

  static String region_status = '/api/v1/main/region-stat';

  static String getSearchSuggestion = "/api/v1/search/suggestions";
  

  static _pingOneTime(String host, int port,
      {Duration timeout = const Duration(seconds: 5)}) {
    DateTime startTime = DateTime.now();

    return Socket.connect(host, port, timeout: timeout).then((socket) {
      socket.destroy();
      return DateTime.now().difference(startTime);
    }).catchError((error) {
      // return Future.value(null);
    });
  }

  static _ping(
    String host,
    int port, {
    int count = 3,
    required Function callback,
  }) {
    for (int i = 0; i < count; i++) {
      _pingOneTime(host, port).then(callback);
    }
  }

  static _searchForConnection({required Function onResult}) {
    var timer = Timer(const Duration(seconds: 6), () {
      onResult(false);
    });

    for (var element in availableHosts) {
      List<String> split = element.split(':');
      String _host = split.first;
      int _port = 80;

      if (split.length > 1) {
        _port = int.parse(split.last);
      }

      _ping(_host, _port, callback: (dynamic time) {
        if (time != null && time is Duration) {
          if (host.isNotEmpty) return;
          host = _host;
          if (_port != 80) host += ":$_port";
          timer.cancel();
          onResult(true);
        }
      });
    }
  }

  static searchForConnection() async {
    Completer c = Completer();
    _searchForConnection(onResult: (e) => c.complete(e));
    return c.future;
  }
}
