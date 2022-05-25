import 'package:flutter/material.dart';
import 'package:tm/ui/size_config.dart';

class NextBtn extends StatelessWidget {
  final bool icon_status;
  final Function press;
  final String text;
  final IconData? icon;
  const NextBtn({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
    this.icon_status = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => press(),
      child: Container(
        width: SizeConfig.screenWidth * 0.29,
        padding: const EdgeInsets.fromLTRB(14, 5, 10, 4),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 70, 172, 73),
              Color.fromARGB(255, 0, 27, 1),
            ],
          ),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Text(
            text.toUpperCase(),
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          icon_status ? const Spacer() : Container(),
          icon_status
              ? Icon(
                  icon,
                  color: Colors.white,
                )
              : Container()
        ]),
      ),
    );
  }
}

class PrevBtn extends StatelessWidget {
  final Function press;
  final String text;
  final IconData icon;
  const PrevBtn({
    Key? key,
    required this.press,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => press(),
      child: Container(
        width: SizeConfig.screenWidth * 0.28,
        padding: const EdgeInsets.fromLTRB(14, 5, 10, 4),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 70, 172, 73),
              Color.fromARGB(255, 0, 27, 1),
            ],
          ),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
          ),
          const Spacer(),
          Text(
            text.toUpperCase(),
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ]),
      ),
    );
  }
}

class NextPreBtn extends StatelessWidget {
  final String submit_btn;
  final Function press_next;
  final Function press_prev;
  final bool icon_status;

  const NextPreBtn(
      {Key? key,
      required this.press_prev,
      required this.press_next,
      required this.submit_btn,
      this.icon_status = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        PrevBtn(
          press: press_prev,
          icon: Icons.arrow_left_sharp,
          text: 'back',
        ),
        NextBtn(
          icon_status: icon_status,
          text: submit_btn,
          icon: icon_status ? Icons.arrow_right_sharp : null,
          press: press_next,
        )
      ],
    );
  }
}
