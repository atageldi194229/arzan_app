import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tm/core/providers/region_status_provider.dart';

import './statistic_tile.dart';

class StatisticsDataTable extends StatefulWidget {
  final dynamic data;
  const StatisticsDataTable(
    this.data, {
    Key? key,
  }) : super(key: key);

  @override
  State<StatisticsDataTable> createState() => _StatisticsDataTableState();
}

class _StatisticsDataTableState extends State<StatisticsDataTable> {
  @override
  Widget build(BuildContext context) {
    RegionStatusProvidor statisticProvider =
        context.watch<RegionStatusProvidor>();

    if (statisticProvider.list.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // children: [
        //   TextButton(
        //       onPressed: () {
        //         debugPrint(statisticProvider.list.where((element) => ));
        //       },
        //       child: Text('asd'))
        // ],
        children: [
          StatisticTile(
            icon: Icons.favorite_border_rounded,
            title: 'Halanylanlar',
            stats: widget.data!.likeCount.toString(),
          ),
          StatisticTile(
            icon: Icons.share_outlined,
            title: 'Paýlaşylanlar',
            stats: widget.data!.shareCount.toString(),
          ),
          StatisticTile(
            icon: Icons.create,
            title: 'Goşulan postlar',
            stats: widget.data!.postCount.toString(),
          ),
          StatisticTile(
            icon: Icons.visibility_outlined,
            title: 'Seredilenler',
            stats: widget.data!.viewCount.toString(),
          ),
        ],

        // children: [

        // ],
        // children: statisticProvider.list
        //     .map(
        //       (e) => StatisticTile(
        //           icon: Icons.create,
        //           title: e.name.toString() ?? 'no name',
        //           stats: e.month!.likeCount.toString()),
        //     )
        //     .toList(),
      ),
    );
  }
}
