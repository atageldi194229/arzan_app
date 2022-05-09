import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tm/core/api/models/index.dart';
import 'package:tm/core/providers/notification_provider.dart';
import 'package:tm/ui/screens/notification_detail/notification_detail_screen.dart';
import './notification_card.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<NotificationProvider>().fetchData();

    // Setup the listener.
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (isTop) {
        } else {
          context.read<NotificationProvider>().fetchData();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    NotificationProvider notificationProvider =
        context.watch<NotificationProvider>();

    if (notificationProvider.isFetching) {
      return const Center(child: CircularProgressIndicator());
    }

    List<NotificationModel> notifications = notificationProvider.items;

    return ListView.builder(
      controller: _controller,
      itemCount: notifications.length,
      itemBuilder: (BuildContext context, index) => NotificationCard(
        notifications[index],
        onTap: () {
          context.read<NotificationProvider>().currentIndex = index;
          Navigator.pushNamed(context, NotificationDetailScreen.routeName);
        },
      ),
    );

    // return const Center(
    //   child: Text("Could not get data"),
    // );
  }
}
