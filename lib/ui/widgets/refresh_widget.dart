import 'package:flutter/material.dart';

class RefreshWidget extends StatefulWidget {
  final Widget child;
  final Future Function() onRefresh;
  const RefreshWidget({
    Key? key,
    required this.child,
    required this.onRefresh,
  }) : super(key: key);

  @override
  State<RefreshWidget> createState() => _RefreshWidgetState();
}

class _RefreshWidgetState extends State<RefreshWidget> {
  @override
  Widget build(BuildContext context) => buildAndroidList();

  Widget buildAndroidList() => RefreshIndicator(
        child: widget.child,
        onRefresh: widget.onRefresh,
      );
}
