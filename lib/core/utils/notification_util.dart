import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class NotificationUtil {
  void showNotification(
    FlutterLocalNotificationsPlugin flnp,
    String title,
    String image,
    String body,
  ) async =>
      await _demoNotification(
        flnp: flnp,
        title: title,
        image: image,
        body: body,
      );

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory? directory = await getExternalStorageDirectory();
    final String filePath = '${directory!.path}/$fileName.png';
    final http.Response response = await http.get(Uri.parse(url));

    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future<void> _demoNotification({
    required FlutterLocalNotificationsPlugin flnp,
    required String title,
    required String image,
    required String body,
  }) async {
    // final String largeIconPath = await _downloadAndSaveFile(
    //   'https://via.placeholder.com/48x48',
    //   'largeIcon',
    // );

    final String bigPicturePath = await _downloadAndSaveFile(
      image,
      'bigPicture',
    );

    var iOSChannelSpecifics = const IOSNotificationDetails();
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'atasanarzan',
      'arzan-notifier-channel',
      channelDescription: 'arzan notifications',
      importance: Importance.max,
      playSound: true,
      showProgress: true,
      priority: Priority.max,
      largeIcon: FilePathAndroidBitmap(bigPicturePath),
      // color: kSoftGreen,
      styleInformation: BigPictureStyleInformation(
        FilePathAndroidBitmap(bigPicturePath),
        hideExpandedLargeIcon: false,
        contentTitle: '<b>$title</b>', // 'overridden <b>big</b> content title',
        htmlFormatContentTitle: true,
        summaryText: body, // 'summary <i>text</i>',
        htmlFormatSummaryText: true,
      ),
    );

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);
    await flnp.show(0, title, body, platformChannelSpecifics);
  }
}
