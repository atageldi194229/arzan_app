import 'package:flutter/material.dart';
import 'package:tm/ui/size_config.dart';

class NextBtn extends StatelessWidget {
  final bool iconStatus;
  final Function press;
  final String text;
  final IconData? icon;
  const NextBtn({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
    this.iconStatus = true,
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
          iconStatus ? const Spacer() : Container(),
          iconStatus
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

class PrevNextBtns extends StatelessWidget {
  final Function pressNext;
  final Function pressBack;
  const PrevNextBtns({
    Key? key,
    required this.pressNext,
    required this.pressBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () => pressBack,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.arrow_left,
                  color: Colors.white,
                ),
                Text(
                  'back'.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => pressNext,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Text(
                  'next'.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const Icon(
                  Icons.arrow_right,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
