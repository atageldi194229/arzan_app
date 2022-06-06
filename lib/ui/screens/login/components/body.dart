import 'package:tm/core/api/services/auth_service.dart';
import 'package:tm/core/localization/index.dart';
import 'package:tm/core/providers/account_provider.dart';
import 'package:tm/core/providers/auth_provider.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/helper/arzan_show_dialogs.dart';
import 'package:tm/ui/helper/keyboard.dart';
import 'package:tm/ui/screens/home/home_screen.dart';
import 'package:tm/ui/screens/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tm/ui/size_config.dart';
import 'package:tm/ui/widgets/full_screen_loading.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isLoading = false;

  String? errorUsername;
  String? errorPassword;

  TextEditingController phoneInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();

  _onLogin() {
    var userId = context.read<AuthProvider>().userId;
    context.read<AccountProvider>().initUser(userId: userId);

    Navigator.pop(context);
    Navigator.pushNamed(context, HomeScreen.routeName);
    showDialogSuccess(context);
  }

  void _tryLogin() async {
    KeyboardUtil.hideKeyboard(context);
    String username = phoneInputController.text;
    String password = passwordInputController.text;

    setState(() => isLoading = true);

    var result = await AuthService().checkUser(
      username: username,
      phoneNumber: username,
    );

    if (!result['username']) {}

    if (!result['phoneNumber']) {
      setState(() {
        errorUsername = 'Phone number already exists';
      });
    }

    if (result['username'] && result['phoneNumber']) {
      setState(() {
        errorUsername = 'Username or phone number not found';
        isLoading = false;
      });
      return;
    }

    context.read<AuthProvider>().login(
        username: username,
        password: password,
        onLogin: _onLogin,
        onPasswordIncorrect: () {
          setState(() {
            isLoading = false;
            errorPassword = "Username or password is incorrect";
          });
        },
        onError: () {
          debugPrint("error on login try@@@");
          setState(() => isLoading = false);
          showDialogFailed(context);
        });
  }

  @override
  void dispose() {
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
    // bool _keyboardVisibility = MediaQuery.of(context).viewInsets.bottom != 0;

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
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(30)),
                Expanded(
                  child: Image.asset("assets/images/logo_app.png"),
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter phone number';
                            }
                            return null;
                          },
                          controller: phoneInputController,
                          onSaved: (_) => _tryLogin(),
                          onChanged: (_) {
                            setState(() => errorUsername = null);
                          },
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
                              errorText: errorUsername,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                          controller: passwordInputController,
                          obscureText: _obscureText,
                          onSaved: (_) => _tryLogin(),
                          onChanged: (_) {
                            setState(() => errorPassword = null);
                          },
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
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: kSoftGreen,
                              ),
                              onPressed: () => _toggle(),
                            ),
                            contentPadding: const EdgeInsets.all(0),
                            hintText: context.tt('password'),
                            errorText: errorPassword,
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
                        onTap: () => {
                          if (_formKey.currentState!.validate())
                            {
                              _tryLogin(),
                            },
                        },
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
                        onTap: () => Navigator.pushNamed(
                            context, RegisterScreen.routeName),
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
                                    fontWeight: FontWeight.bold),
                              ),
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
                      const SizedBox(height: 10)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: isLoading,
          child: const FullScreenLoading(),
        ),
      ],
    );
  }
}
