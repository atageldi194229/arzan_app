import 'package:tm/core/providers/auth_provider.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/helper/keyboard.dart';
import 'package:tm/ui/helper/toast.dart';
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
    print("I MA HERE BROROOROOROROOO");

    String username = context.read<AuthProvider>().username;

    showToast(context, "$username successfully logged in.");

    Navigator.pop(context);
    Navigator.pushNamed(context, HomeScreen.routeName);
  }

  void _tryLogin() async {
    KeyboardUtil.hideKeyboard(context);

    String username = phoneInputController.text;
    String password = passwordInputController.text;

    print("try login: $username $password");

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
    Size _size = MediaQuery.of(context).size;
    // bool _keyboardVisibility = MediaQuery.of(context).viewInsets.bottom != 0;

    return SingleChildScrollView(
      child: Container(
        width: _size.width,
        height: _size.height * 0.87,
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
              child:  Image.asset("assets/images/logo_app.png"),
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
                          hintText: '+993 phone number or username',
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
                              _obscureText ? Icons.visibility : Icons.visibility_off,
                              color: kSoftGreen,
                            ),
                            onPressed: () => _toggle(),
                          ),
                        contentPadding: const EdgeInsets.all(0),
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const Expanded(
                      child:  Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => _tryLogin(),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                          color: kSoftGreen,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        'ENTER',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, RegisterScreen.routeName),
                    child:   RichText(
                        text:  TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: getProportionateScreenWidth(32)), 
                            children:const <TextSpan>[
                              TextSpan(text: "Don't have an account? ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                              TextSpan(text: 'Sign in', style: TextStyle(color: Color.fromARGB(255, 12, 121, 15), fontWeight: FontWeight.bold))
                            ],
                        ),
                                    textScaleFactor: 0.5,
                                    )
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
