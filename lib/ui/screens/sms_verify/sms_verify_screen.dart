import 'dart:async';

import 'package:tm/core/api/services/auth_service.dart';
import 'package:tm/core/localization/index.dart';
import "package:flutter/material.dart";
import 'package:tm/ui/widgets/default_appbar.dart';
import 'package:tm/ui/widgets/full_screen_loading.dart';
import 'package:url_launcher/url_launcher.dart';

class SmsVerifyScreen extends StatefulWidget {
  static const routeName = '/sms_verify';
  const SmsVerifyScreen({Key? key}) : super(key: key);

  @override
  State<SmsVerifyScreen> createState() => _SmsVerifyScreenState();
}

class _SmsVerifyScreenState extends State<SmsVerifyScreen> {
  final int _timeInterval = 5;
  final int _waitTime = 6 * 50;
  Timer? timer;
  bool isLoading = false;
  int? smsSentTime;
  Future<bool> Function()? verify;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as SmsVerifyScreenArguments;

    verify = args.onVerify;

    int left = -1; // in seconds

    if (timer != null) {
      left = _timeInterval - timer!.tick % _timeInterval;
    }

    return Scaffold(
      appBar: DefaultAppBar(title: context.tt('sms verify')),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            width: double.infinity,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(context.tt("phone_number_verification")),
                  ElevatedButton(
                    onPressed: () => _startVerify(args.phoneNumber),
                    child: const Text('verify'),
                  ),
                  if (left != -1) Text("To next check left: $left"),
                ],
              ),
            ),
          ),
          Visibility(
            visible: isLoading,
            child: const FullScreenLoading(),
          ),
          if (timer != null)
            LinearProgressIndicator(value: timer!.tick / _waitTime),
        ],
      ),
    );
  }

  _startVerify(String phoneNumber) async {
    setState(() => isLoading = true);

    var responseBody = await AuthService().getSmsData(phoneNumber);

    setState(() => isLoading = false);

    String smsVerifyPhoneNumber = responseBody['phone_number'];
    String smsVerifyCode = responseBody['text'];

    _sendSMS(smsVerifyPhoneNumber, smsVerifyCode);

    _startTimer();
  }

  _sendSMS(String tel, String body) {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    Uri url = Uri(
      scheme: 'sms',
      path: tel,
      query: encodeQueryParameters(<String, String>{
        'body': body,
      }),
    );

    launchUrl(url);

    smsSentTime = DateTime.now().millisecondsSinceEpoch;
  }

  _startTimer() {
    timer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      debugPrint(timer.tick.toString());

      setState(() {});

      if (timer.tick >= _waitTime) _closePage();

      if (timer.tick % _timeInterval != 0) return;
      if (verify == null) return;

      bool result = await verify!();

      debugPrint("result of verify: $result");

      if (result) {
        _closePage();
      }
    });
  }

  _closePage() {
    timer?.cancel();
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}

class SmsVerifyScreenArguments {
  final String phoneNumber;
  final Future<bool> Function() onVerify;

  SmsVerifyScreenArguments({
    required this.phoneNumber,
    required this.onVerify,
  });
}
