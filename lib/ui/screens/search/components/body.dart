import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tm/core/providers/post_search_provider.dart';
import 'package:tm/ui/screens/search/components/result_list_view.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    context.read<PostSearchProvider>().loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return const ResultListView();
  }
}
