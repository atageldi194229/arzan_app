import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tm/core/api/models/user.dart';
import 'package:tm/core/providers/official_user_list_provider.dart';
import 'package:tm/ui/components/official_user.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/widgets/default_appbar.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    OfficialUserListProvider provider =
        context.watch<OfficialUserListProvider>();

    List<UserModel> officials = provider.items;

    if (officials.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          expandedHeight: size.height / 8,
          automaticallyImplyLeading: false,
          floating: true,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            background: const DefaultAppBar(
              title: 'Official users',
              count: true,
              countAppBar: 33,
            ),
            centerTitle: true,
            titlePadding: const EdgeInsets.symmetric(horizontal: 10),
            title: FittedBox(
              child: SizedBox(
                width: size.width,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 5.0,
                        vertical: 9.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: kBoxShadow,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.grid_view_rounded,
                          color: kSoftGreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: GridView.builder(
            itemCount: officials.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.65,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemBuilder: (context, index) => OfficialUser(
              officials[index],
              iconShow: false,
            ),
          ),
        )
      ],
    );
  }
}
