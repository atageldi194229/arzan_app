import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tm/core/localization/index.dart';
import 'package:tm/core/utils/notification_util.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/screens/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tm/ui/routes.dart';

// screens || pages
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'core/providers/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TT.init();
//afisha.arzan.tm

  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: providers,
      child: const TTranslate(child: MyApp()),
    ),
  );
}

printToken() async {
  print("get token started");
  String? token = await FirebaseMessaging.instance.getToken();
  print("FIREBASE MESSAGING TOKEN: $token");
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  FlutterLocalNotificationsPlugin flnp = FlutterLocalNotificationsPlugin();

  initNotification() {
    var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = const IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    var initializationSettings =
        InitializationSettings(android: android, iOS: iOS);
    flnp.initialize(initializationSettings);
  }

  @override
  void initState() {
    super.initState();
    initNotification();
    FirebaseMessaging.onMessage.listen((RemoteMessage msg) {
      RemoteNotification? notification = msg.notification;
      NotificationUtil().showNotification(
          flnp,
          notification?.title ?? 'No title',
          msg.data['image'].toString(),
          notification?.body ?? 'No body');
    });
    // FirebaseMessaging.onBackgroundMessage((message) => null)
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    printToken();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Arzan',
      theme: ThemeData(
          scaffoldBackgroundColor: kScaffoldColor,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
              .copyWith(secondary: Colors.green)
              .copyWith(secondary: Colors.green)),
      // theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      // initialRoute: TestScreen.routeName,
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
