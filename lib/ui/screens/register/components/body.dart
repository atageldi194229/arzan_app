import 'dart:async';
import 'package:tm/core/api/services/auth_service.dart';
import 'package:tm/core/localization/index.dart';
import 'package:tm/core/providers/account_provider.dart';
import 'package:tm/ui/helper/arzan_show_dialogs.dart';
import 'package:tm/ui/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/screens/sms_verify/sms_verify_screen.dart';
import 'package:tm/ui/widgets/full_screen_loading.dart';

import '../../../../core/providers/auth_provider.dart';
import '../../../size_config.dart';
import '../../home/home_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isLoading = false;

  TextEditingController usernameInputController = TextEditingController();
  TextEditingController phoneInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();

  String? errorUsername;
  String? errorPhoneNumber;
  String? errorPassword;

  int smsSentTime = 0; // in ms
  int expireTime = 2 * 60 * 1000; // in ms

  _onRegister() {
    var userId = context.read<AuthProvider>().userId;
    context.read<AccountProvider>().initUser(userId: userId);

    Navigator.pop(context);
    Navigator.pushNamed(context, HomeScreen.routeName);
    showDialogSuccess(context);
  }

  _verifySms() {
    String phoneNumber = phoneInputController.text;
    String username = usernameInputController.text;
    String password = passwordInputController.text;

    Navigator.pushNamed(
      context,
      SmsVerifyScreen.routeName,
      arguments: SmsVerifyScreenArguments(
        phoneNumber: phoneNumber,
        onVerify: () {
          Completer<bool> c = Completer();

          context.read<AuthProvider>().register(
                username: username,
                phoneNumber: phoneNumber,
                password: password,
                notYet: () {
                  c.complete(false);
                },
                onRegister: () {
                  c.complete(true);
                  _onRegister();
                },
              );

          return c.future;
        },
      ),
    );
  }

  _validateAndNextPage() async {
    setState(() => isLoading = true);

    String phoneNumber = phoneInputController.text;
    String username = usernameInputController.text;

    var result = await AuthService().checkUser(
      username: username,
      phoneNumber: phoneNumber,
    );

    if (!result['username']) {
      setState(() {
        errorUsername = 'Username already used';
      });
    }

    if (!result['phoneNumber']) {
      setState(() {
        errorPhoneNumber = 'Phone number already exists';
      });
    }

    if (result['username'] && result['phoneNumber']) {
      _verifySms();
    } else {
      debugPrint("validation error broooooooooooooo");
    }

    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    usernameInputController.dispose();
    phoneInputController.dispose();
    passwordInputController.dispose();
    super.dispose();
  }

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height * 0.87,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                boxShadow: kBoxShadow,
                color: Colors.white,
                borderRadius: BorderRadius.circular(15)),
            child: registerPage(),
          ),
        ),
        Visibility(
          visible: isLoading,
          child: const FullScreenLoading(),
        ),
      ],
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
            key: _formKey,
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
        DefaultButtonGreen(
          press: () {
            if (_formKey.currentState!.validate()) {
              _validateAndNextPage();
            }
          },
          text: context.tt("register").toUpperCase(),
        ),
        const SizedBox(height: 30),
        InkWell(
          onTap: () => Navigator.pushNamed(context, LoginScreen.routeName),
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateScreenWidth(32)),
              children: <TextSpan>[
                TextSpan(
                    text: context.tt("already_have_account"),
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                TextSpan(
                    text: context.tt("sign_in"),
                    style: const TextStyle(
                        color: Color.fromARGB(255, 12, 121, 15),
                        fontWeight: FontWeight.bold))
              ],
            ),
            textScaleFactor: 0.5,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  TextFormField buildUsernameFormField() {
    return TextFormField(
      onChanged: (value) => setState(() => errorUsername = null),
      controller: usernameInputController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Fill empty field';
        }

        if (!usernameValidatorRegExp.hasMatch(value)) {
          return 'length-range: 3-30, can be: 0-9, a-z, A-Z';
        }

        return null;
      },
      decoration: InputDecoration(
        fillColor: Colors.grey.shade100,
        filled: true,
        prefixIcon: const Icon(
          Icons.person_outline_rounded,
          color: kSoftGreen,
        ),
        contentPadding: const EdgeInsets.all(0),
        hintText: context.tt("username"),
        errorText: errorUsername,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  TextFormField buildPhoneNumberFormFeild() {
    return TextFormField(
      onChanged: (value) => setState(() => errorPhoneNumber = null),
      controller: phoneInputController,
      validator: (value) {
        if (value == null || value.isEmpty) return "Fill empty field";

        if (!value.startsWith("+993")) {
          return "Phone number should start with +993";
        }

        if (value.length != 12) {
          return 'Length should be 12';
        }

        return null;
      },
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
          errorText: errorPhoneNumber,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      onChanged: (value) => setState(() => errorPassword = null),
      controller: passwordInputController,
      obscureText: _obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Fill empty field';
        }

        if (value.length < 6) {
          return 'Should be minimum 6 characters';
        }

        return null;
      },
      decoration: InputDecoration(
        fillColor: Colors.grey.shade100,
        filled: _obscureText,
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            _obscureText ? Icons.visibility_off : Icons.visibility,
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
        errorText: errorPassword,
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
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
}
