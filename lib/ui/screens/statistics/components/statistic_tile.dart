import 'package:flutter/material.dart';
import 'package:tm/ui/constants.dart';

class StatisticTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String stats;
  const StatisticTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.stats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: kSoftGreen,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.white),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.normal),
              ),
            ),
          ),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                stats.toString(),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
