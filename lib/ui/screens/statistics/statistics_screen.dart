import 'package:provider/provider.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/screens/add_post/components/regions.dart';
import 'package:tm/ui/widgets/default_appbar.dart';
import 'package:flutter/material.dart';

import '../../../core/api/models/region_status.dart';
import '../../../core/providers/region_status_provider.dart';

int currentTab = 0;

class StatisticsScreen extends StatefulWidget {
  static const routeName = '/statistics';
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController!
        .addListener(() => setState(() => currentTab = _tabController!.index));
  }

  @override
  Widget build(BuildContext context) {
    int? getValue;

    List<RegionStatusModel> regions =
        context.watch<RegionStatusProvidor>().list;

    List<String> regionNames = regions.map((e) => e.name ?? '').toList();
    return Scaffold(
      appBar: const DefaultAppBar(title: 'My statistics'),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(getValue.toString()),
                Regions(
                  items: regionNames,
                  onChanged: (index) {
                    getValue = index;
                    print(getValue);
                    context
                        .read<RegionStatusProvidor>()
                        .setSelectedRegion(regions[index]);
                  },
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey, spreadRadius: .1, blurRadius: 2)
                      ]),
                  child: Text('',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: kSoftGreen, fontWeight: FontWeight.bold)),
                ),
                DefaultTabController(
                    length: 3, // length of tabs
                    initialIndex: 0,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const TabBar(
                            labelColor: Colors.green,
                            unselectedLabelColor: Colors.black,
                            tabs: [
                              Tab(text: 'Day'),
                              Tab(text: 'Week'),
                              Tab(text: 'Month'),
                            ],
                          ),
                          Container(
                              height: 300, //height of TabBarView
                              decoration: const BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          color: Colors.grey, width: 0.5))),
                              child: const TabBarView(children: [
                                StatisticsDataTable(),
                                StatisticsDataTable(),
                                StatisticsDataTable(),
                              ]))
                        ])),
              ]),
        ),
      ),
    );
  }
}

class StatisticsDataTable extends StatefulWidget {
  const StatisticsDataTable({
    Key? key,
  }) : super(key: key);

  @override
  State<StatisticsDataTable> createState() => _StatisticsDataTableState();
}

class _StatisticsDataTableState extends State<StatisticsDataTable> {
  void initState() {
    super.initState();
    context.read<RegionStatusProvidor>().loadStatistics();
  }

  @override
  Widget build(BuildContext context) {
    RegionStatusProvidor statisticProvider =
        context.watch<RegionStatusProvidor>();

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // children: [
        //   TextButton(
        //       onPressed: () {
        //         print(statisticProvider.list.map((e) => e.month!.postCount));
        //       },
        //       child: Text('asd'))
        // ],
        children: [
          StatisticTile(icon: Icons.create, title: 'All posts', stats: '81'),
          StatisticTile(
              icon: Icons.visibility_outlined, title: 'Views', stats: '4868'),
          StatisticTile(
              icon: Icons.favorite_border_rounded, title: 'Likes', stats: '3'),
          StatisticTile(
              icon: Icons.share_outlined, title: 'Shared', stats: '2'),
          TextButton(
              child: Text('asd'),
              onPressed: () {
                context.read<RegionStatusProvidor>().loadStatistics();
                for (var i in statisticProvider.list) {
                  print(i);
                }
              }),
        ],
        // children: statisticProvider.list
        //     .map(
        //       (e) => StatisticTile(
        //           icon: Icons.create,
        //           title: e.day.toString() ?? 'no name',
        //           stats: e.month!.likeCount.toString()),
        //     )
        //     .toList(),
      ),
    );
  }
}

class StatisticTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String stats;
  const StatisticTile(
      {Key? key, required this.icon, required this.title, required this.stats})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: kSoftGreen, borderRadius: BorderRadius.circular(10)),
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
          )),
          Flexible(
              child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              stats,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
          )),
        ],
      ),
    );
  }
}
