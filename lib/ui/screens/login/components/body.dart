import 'package:tm/core/localization/index.dart';
import 'package:tm/core/providers/auth_provider.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/helper/arzan_show_dialogs.dart';
import 'package:tm/ui/helper/keyboard.dart';
import 'package:tm/ui/screens/home/home_screen.dart';
import 'package:tm/ui/screens/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tm/ui/size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController phoneInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();

  _onLogin() {
    // String username = context.read<AuthProvider>().username;

    Navigator.pop(context);
    Navigator.pushNamed(context, HomeScreen.routeName);
    showDialogSuccess(context);
  }

  void _tryLogin() async {
    KeyboardUtil.hideKeyboard(context);
    String username = phoneInputController.text;
    String password = passwordInputController.text;

    context.read<AuthProvider>().login(
          username: username,
          password: password,
          onLogin: _onLogin,
        );
  }

  @override
  void dispose() {
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
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(30)),
            Expanded(
              child: Image.asset("assets/images/logo_app.png"),
            ),
            SizedBox(height: getProportionateScreenHeight(30)),
            Expanded(
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: phoneInputController,
                      onSaved: (_) => _tryLogin(),
                      // keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          prefixIcon: const Icon(
                            Icons.person_outline_rounded,
                            color: kSoftGreen,
                          ),
                          contentPadding: const EdgeInsets.all(0),
                          hintText: context.tt('username_phone'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: passwordInputController,
                      obscureText: _obscureText,
                      onSaved: (_) => _tryLogin(),
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.lock_outline_rounded,
                          color: kSoftGreen,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: kSoftGreen,
                          ),
                          onPressed: () => _toggle(),
                        ),
                        contentPadding: const EdgeInsets.all(0),
                        hintText: context.tt('password'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            child: Text(
                              context.tt('forget_password'),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 105, 104, 104),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  InkWell(
                    onTap: () => _tryLogin(),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: kSoftGreen,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        context.tt('login'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, RegisterScreen.routeName),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: getProportionateScreenWidth(32)),
                        children: <TextSpan>[
                          TextSpan(
                              text: context.tt('dont_have_account'),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: context.tt('sign_up'),
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 12, 121, 15),
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                      textScaleFactor: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
