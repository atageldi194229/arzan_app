import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tm/core/api/models/region_status.dart';
import 'package:tm/core/providers/region_status_provider.dart';
import 'package:tm/ui/helper/flutter_3_ambiguate.dart';
import 'package:tm/ui/screens/add_post/components/regions.dart';

import './statistics_data_table.dart';

int currentTab = 0;

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
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

    return SingleChildScrollView(
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
    );
  }
}
