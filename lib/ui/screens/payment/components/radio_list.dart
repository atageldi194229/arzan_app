import "package:flutter/material.dart";
import 'package:tm/core/localization/index.dart';

class RadioList extends StatefulWidget {
  final Function press;
  final bool price_status;
  final int? price;
  final String text;
  final int value;
  final int groupVal;
  final bool selectedValue;

  const RadioList({
    Key? key,
    required this.text,
    required this.value,
    required this.groupVal,
    required this.press,
    this.selectedValue = false,
    this.price_status = false,
    this.price,
  }) : super(key: key);

  @override
  State<RadioList> createState() => _RadioListState();
}

class _RadioListState extends State<RadioList> {
  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      value: widget.value,
      activeColor: Colors.green,
      groupValue: widget.groupVal,
      onChanged: (value) => widget.press,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            context.tt(widget.text),
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w700),
          ),
          widget.price != null
              ? Text(
                  "${widget.price.toString()} TMT",
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                )
              : Container()
        ],
      ),
      selected: widget.selectedValue,
    );
  }
}
