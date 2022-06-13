import 'package:tm/ui/constants.dart';
import 'package:flutter/material.dart';

class DefaultAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool count;
  final int? countAppBar;
  final bool backgroundChange;
  const DefaultAppBar({
    Key? key,
    required this.title,
    this.count = false,
    this.countAppBar,
    this.backgroundChange = false,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  DefaultAppBarState createState() => DefaultAppBarState();
}

class DefaultAppBarState extends State<DefaultAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.backgroundChange ? Colors.green : Colors.white,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              color: widget.backgroundChange ? Colors.white : kTextColor,
            ),
          ),
          widget.count
              ? Text(
                  widget.countAppBar.toString(),
                  style: const TextStyle(color: kTextColor),
                )
              : Container()
        ],
      ),
      leading: LayoutBuilder(
        builder: (context, constraints) {
          return IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.chevron_left_rounded,
              color: widget.backgroundChange ? Colors.white : kSoftGreen,
              size: constraints.biggest.width / 1.5,
            ),
          );
        },
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
    );
  }
}
