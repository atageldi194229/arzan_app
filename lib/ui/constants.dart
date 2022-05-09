import 'package:flutter/material.dart';
import './size_config.dart';

// arzan contants starts here

List<BoxShadow> kBoxShadow = [
  BoxShadow(
    blurRadius: 3,
    offset: const Offset(0, 2),
    spreadRadius: 0,
    color: Colors.grey.withOpacity(0.5),
  )
];

const String imagePlaceholder = "assets/images/1x1.png";

const Color kHardGreen = Color(0xFF0B6D20);
const Color kSoftGreen = Color(0xFF59B638);

const aPrimaryColor = Color(0xFF4DA13F);
const aPrimaryGradientColor = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    kHardGreen,
    kSoftGreen,
  ],
);

const BorderRadius kBorderRadius = BorderRadius.all(
  Radius.circular(5),
);

BoxDecoration kCardDecoration = BoxDecoration(
  color: Colors.white,
  boxShadow: kBoxShadow,
  borderRadius: kBorderRadius,
);

// arzan contants ends here

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
const kScaffoldColor = Color(0xFFEEEEEE);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp phoneValidatorRegExp = RegExp(r"^\+993[0-9]{8}$");
final RegExp usernameValidatorRegExp = RegExp(r"^[0-9a-zA-Z]{3,30}");
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: const BorderSide(color: kTextColor),
  );
}

class DefaultButtonGreen extends StatelessWidget {
  const DefaultButtonGreen({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);
  final String text;
  final GestureTapCallback press;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => press(),
      child: Container(
        padding: const EdgeInsets.all(10),
        // margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: kSoftGreen, borderRadius: BorderRadius.circular(10)),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
