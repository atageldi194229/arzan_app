import 'package:tm/ui/screens/home/components/custom_app_bar.dart';
import 'package:tm/ui/screens/home/components/recommended_carts.dart';
import 'package:flutter/material.dart';

import 'post_sliver_list.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomAppBar(
      children: [
        SliverToBoxAdapter(
          child: RecommendedCarts(),
        ),
        PostSliverList(),
      ],
    );
  }
}
