import 'package:tm/core/providers/home_screen_provider.dart';
import 'package:tm/core/providers/region_provider.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/screens/home/components/app_bar_button.dart';
import 'package:tm/ui/screens/notifications/notifications_screen.dart';
import 'package:tm/ui/screens/official_users/official_users_screen.dart';
import 'package:tm/ui/screens/select_region/select_region_screen.dart';
import 'package:tm/ui/screens/statistics/statistics_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'banner_carousel.dart';

class CustomAppBar extends StatefulWidget {
  final List<Widget> children;

  const CustomAppBar({Key? key, required this.children}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    // Setup the listener.
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (!isTop) {
          context.read<HomeScreenProvider>().loadPosts();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String currentRegionName =
        context.watch<RegionProvider>().currentRegion.name;

    return CustomScrollView(
      controller: _controller,
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          floating: false,
          pinned: true,
          snap: false,
          forceElevated: true,
          // elevation: 10,
          automaticallyImplyLeading: false,
          expandedHeight: size.height / 2.5,
          // excludeHeaderSemantics: true,
          // leading: ,
          primary: true,
          backgroundColor: Colors.white,
          // toolbarHeight: kToolbarHeight,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            stretchModes: const [StretchMode.blurBackground],
            background: Container(
              // color: kSoftGreen,
              padding: const EdgeInsets.only(bottom: kToolbarHeight),
              width: double.infinity,
              // height: size.height / 3.2,
              child: const BannerCarousel(),
            ),
            centerTitle: true,
            expandedTitleScale: 1.0,
            titlePadding: const EdgeInsetsDirectional.only(start: 0, bottom: 0),
            title: Container(
              height: kToolbarHeight,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: AppBarButton(
                      child: const Icon(
                        Icons.leaderboard_rounded,
                        color: kSoftGreen,
                      ),
                      onTap: () => Navigator.pushNamed(
                          context, StatisticsScreen.routeName),
                    ),
                  ),
                  Expanded(
                    child: AppBarButton(
                      child: const Icon(
                        Icons.notifications_rounded,
                        color: kSoftGreen,
                      ),
                      onTap: () => Navigator.pushNamed(
                          context, NotificationsScreen.routeName),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: AppBarButton(
                      child: Text(
                        currentRegionName,
                        style: const TextStyle(color: kSoftGreen),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, SelectRegion.routeName);
                      },
                    ),
                  ),
                  Expanded(
                    child: AppBarButton(
                      child: const Icon(
                        Icons.star_outline_rounded,
                        color: kSoftGreen,
                      ),
                      onTap: () => Navigator.pushNamed(
                          context, OfficialUsersScreen.routeName),
                    ),
                  ),
                  Expanded(
                    child: AppBarButton(
                      child: const Icon(
                        Icons.grid_view_rounded,
                        color: kSoftGreen,
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // here children
        ...widget.children,
      ],
    );
  }
}
