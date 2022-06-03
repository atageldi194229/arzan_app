import 'dart:async';

import 'package:tm/core/api/services/auth_service.dart';
import 'package:tm/core/localization/index.dart';
import 'package:tm/core/providers/account_provider.dart';
import 'package:tm/ui/helper/arzan_show_dialogs.dart';
import 'package:tm/ui/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tm/ui/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/providers/auth_provider.dart';
import '../../../helper/keyboard.dart';
import '../../../size_config.dart';
import '../../home/home_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  TextEditingController usernameInputController = TextEditingController();
  TextEditingController phoneInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();

  String? smsVerifyPhoneNumber;
  String smsVerifyCode = '';

  int smsSentTime = 0; // in ms
  int expireTime = 2 * 60 * 1000; // in ms

  _onRegister() {
    // String username = context.read<AuthProvider>().username;
    // showToast(context, "$username successfully logged in.");

    var userId = context.read<AuthProvider>().userId;
    context.read<AccountProvider>().initUser(userId: userId);

    Navigator.pop(context);
    Navigator.pushNamed(context, HomeScreen.routeName);
    showDialogSuccess(context);
  }

  _sendSMS({
    required String tel,
    required String body,
  }) {
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

  _verifySms() {
    String phoneNumber = phoneInputController.text;
    String username = usernameInputController.text;
    String password = passwordInputController.text;

    context.read<AuthProvider>().register(
          username: username,
          phoneNumber: phoneNumber,
          password: password,
          notYet: () {
            Timer(const Duration(seconds: 5), _verifySms);
          },
          onRegister: _onRegister,
        );
  }

  void _tryRegister() async {
    KeyboardUtil.hideKeyboard(context);

    String phoneNumber = phoneInputController.text;

    var responseBody = await AuthService().getSmsData(phoneNumber);

    smsVerifyPhoneNumber = responseBody['phone_number'];
    smsVerifyCode = responseBody['text'];

    _sendSMS(
      tel: smsVerifyPhoneNumber!,
      body: smsVerifyCode,
    );

    _verifySms();
  }

  _validateAndNextPage() async {
    bool anyValidationError = false;

    String phoneNumber = phoneInputController.text;
    String username = usernameInputController.text;
    String password = passwordInputController.text;

    if (!phoneNumber.startsWith("+993") || phoneNumber.length != 12) {
      // if (!phoneValidatorRegExp.hasMatch(phoneNumber)) {
      debugPrint("validation error phonenumber");
      anyValidationError = true;
    }

    if (!usernameValidatorRegExp.hasMatch(username)) {
      debugPrint("validation error username");
      anyValidationError = true;
    }

    if (password.length < 8) {
      debugPrint("validation error password");
      anyValidationError = true;
    }

    var result = await AuthService().checkUser(
      username: username,
      phoneNumber: phoneNumber,
    );

    if (!result['username'] || !result['phoneNumber']) {
      debugPrint("username or phoneNumber already exists");
      anyValidationError = true;
      debugPrint(result);
    }

    if (!anyValidationError) {
      _changePageView(1);
    } else {
      debugPrint("validation error broooooooooooooo");
    }
  }

  _changePageView(int index) {
    KeyboardUtil.hideKeyboard(context);

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    usernameInputController.dispose();
    phoneInputController.dispose();
    passwordInputController.dispose();
    super.dispose();
  }

  bool _obscureText = false;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // bool _keyboardVisibility = MediaQuery.of(context).viewInsets.bottom != 0;

    List<Widget> pages = [
      registerPage(),
      smsVerificationPage(),
    ];

    return SingleChildScrollView(
      child: Container(
        width: size.width,
        height: size.height * 0.87,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            boxShadow: kBoxShadow,
            color: Colors.white,
            borderRadius: BorderRadius.circular(15)),
        child: PageView.builder(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) => pages[index],
          itemCount: pages.length,
        ),
      ),
    );
  }

  Column registerPage() {
    return Column(
      children: [
        Expanded(
          child: Image.asset('assets/images/user_icon.png'),
        ),
        Expanded(
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  buildUsernameFormField(),
                  const SizedBox(height: 10),
                  buildPhoneNumberFormFeild(),
                  const SizedBox(height: 10),
                  buildPasswordFormField(),
                  // const SizedBox(height: 10),
                  // buildPasswordConfirmFormField(),
                ],
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DefaultButtonGreen(
              press: () => _validateAndNextPage(),
              text: context.tt("register").toUpperCase(),
            ),
            const SizedBox(height: 15),
            InkWell(
                onTap: () =>
                    Navigator.pushNamed(context, LoginScreen.routeName),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenWidth(32)),
                    children: <TextSpan>[
                      TextSpan(
                          text: context.tt("already_have_account"),
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: context.tt("sign_in"),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 12, 121, 15),
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  textScaleFactor: 0.5,
                )),
          ],
        ),
      ],
    );
  }

  TextFormField buildUsernameFormField() {
    return TextFormField(
      controller: usernameInputController,
      // onSaved: (_) => _tryLogin(),
      // keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          fillColor: Colors.grey.shade100,
          filled: true,
          prefixIcon: const Icon(
            Icons.person_outline_rounded,
            color: kSoftGreen,
          ),
          contentPadding: const EdgeInsets.all(0),
          hintText: context.tt("username"),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }

  TextFormField buildPhoneNumberFormFeild() {
    return TextFormField(
      controller: phoneInputController,
      // onSaved: (_) => _tryLogin(),
      keyboardType: TextInputType.phone,
      maxLength: 12,
      decoration: InputDecoration(
          fillColor: Colors.grey.shade100,
          filled: true,
          prefixIcon: const Icon(
            Icons.phone,
            color: kSoftGreen,
          ),
          contentPadding: const EdgeInsets.all(0),
          hintText: context.tt("phone_number"),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: passwordInputController,
      obscureText: _obscureText,
      // onSaved: (_) => _tryLogin(),
      decoration: InputDecoration(
        fillColor: Colors.grey.shade100,
        filled: _obscureText,
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: kSoftGreen,
          ),
          onPressed: () => _toggle(),
        ),
        prefixIcon: const Icon(
          Icons.key,
          color: kSoftGreen,
        ),
        contentPadding: const EdgeInsets.all(0),
        hintText: context.tt("password"),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  TextFormField buildPasswordConfirmFormField() {
    return TextFormField(
      controller: passwordInputController,
      obscureText: _obscureText,
      // onSaved: (_) => _tryLogin(),
      decoration: InputDecoration(
        fillColor: const Color.fromRGBO(245, 245, 245, 1),
        filled: true,
        prefixIcon: const Icon(
          Icons.lock_outline_rounded,
          color: kSoftGreen,
        ),
        contentPadding: const EdgeInsets.all(0),
        hintText: context.tt("confirm_the_password"),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget smsVerificationPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(context.tt("phone_number_verification")),
        ElevatedButton(
          onPressed: () => _tryRegister(),
          child: const Text('verify'),
        ),
      ],
    );
  }
}
