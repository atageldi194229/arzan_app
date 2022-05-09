import 'package:flutter/material.dart';
import 'package:tm/core/providers/notification_provider.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/widgets/default_appbar.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';

class NotificationDetailScreen extends StatefulWidget {
  static String routeName = '/notification_detail';
  const NotificationDetailScreen({Key? key}) : super(key: key);

  @override
  State<NotificationDetailScreen> createState() =>
      _NotificationDetailScreenState();
}

class _NotificationDetailScreenState extends State<NotificationDetailScreen> {
  // bool _firstTime = false;
  // firstTimeCall(PageController controller) {
  //   if (_firstTime) return;
  //   _firstTime = true;

  //   controller.addListener(() {
  //     print(controller.page);
  //     if (controller.page != null) {
  //       double next = controller.page!.ceilToDouble() - controller.page!;
  //       double prev = controller.page! - controller.page!.floorToDouble();

  //       const double startScrollPage = 0.2;
  //       const Duration duration = Duration(milliseconds: 300);
  //       const Curve curve = Curves.easeInOut;

  //       print("$prev, $next");

  //       if (startScrollPage > prev) {
  //         controller.nextPage(
  //           duration: duration,
  //           curve: curve,
  //         );
  //       }

  //       if (startScrollPage > next) {
  //         controller.previousPage(
  //           duration: duration,
  //           curve: curve,
  //         );
  //       }
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    List notifications = context.watch<NotificationProvider>().items;
    int currentIndex = context.watch<NotificationProvider>().currentIndex;

    final _controller = PageController(
      initialPage: currentIndex,
    );

    // firstTimeCall(_controller);

    return Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: const DefaultAppBar(title: 'Notification Detail'),
      body: PageView(
        // scrollDirection: Axis.vertical,
        controller: _controller,
        onPageChanged: (index) {
          if (notifications.length - 5 < index) {
            context.read<NotificationProvider>().fetchData();
          }
        },
        children: List.generate(
          notifications.length,
          (index) => Body(
            notifications[index],
            // controller: _controller,
          ),
        ),
      ),
    );
  }

  alertDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding: const EdgeInsets.all(10),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('data', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('data' * 10),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                fillColor: Colors.grey.shade200,
                filled: true,
                hintText: 'Description',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(15),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
