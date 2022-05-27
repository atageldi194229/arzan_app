import 'package:provider/provider.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/helper/flutter_3_ambiguate.dart';
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
  StatisticsScreenState createState() => StatisticsScreenState();
}

class StatisticsScreenState extends State<StatisticsScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;

  int selectedRegionIndex = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );

    _tabController!.addListener(
      () => setState(() => currentTab = _tabController!.index),
    );

    ambiguate(WidgetsBinding.instance)!.addPostFrameCallback((_) {
      RegionStatusProvidor provider = context.read<RegionStatusProvidor>();
      if (provider.list.isEmpty) {
        provider.loadStatistics();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    RegionStatusProvidor statisticProvider =
        context.watch<RegionStatusProvidor>();

    List<RegionStatusModel> regions = statisticProvider.list;

    List<String> regionNames = regions.map((e) => e.name ?? '').toList();

    if (statisticProvider.list.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: const DefaultAppBar(title: 'Statistics'),
      backgroundColor: kScaffoldColor,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Text(regionNames[selectedRegionIndex]),
              Regions(
                defaultItemIndex: selectedRegionIndex,
                items: regionNames,
                onChanged: (index) {
                  setState(() {
                    selectedRegionIndex = index;
                  });
                },
              ),
              // Container(
              //   padding: const EdgeInsets.symmetric(vertical: 15),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(10),
              //     boxShadow: const [
              //       BoxShadow(
              //           color: Colors.grey, spreadRadius: .1, blurRadius: 2)
              //     ],
              //   ),
              //   child: Text(
              //     '',
              //     textAlign: TextAlign.center,
              //     style: Theme.of(context)
              //         .textTheme
              //         .headline5!
              //         .copyWith(color: kSoftGreen, fontWeight: FontWeight.bold),
              //   ),
              // ),
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
                          top: BorderSide(color: Colors.grey, width: 0.5),
                        ),
                      ),
                      child: TabBarView(
                        children: [
                          StatisticsDataTable(
                            statisticProvider.list[selectedRegionIndex].day,
                          ),
                          StatisticsDataTable(
                            statisticProvider.list[selectedRegionIndex].week,
                          ),
                          StatisticsDataTable(
                            statisticProvider.list[selectedRegionIndex].month,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
          )),
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
          )),
        ],
      ),
    );
  }
}
