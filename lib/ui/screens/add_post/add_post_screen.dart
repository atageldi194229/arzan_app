import 'package:tm/ui/screens/add_post/components/body.dart';
import 'package:tm/ui/widgets/default_appbar.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatelessWidget {
  static const routeName = '/add_post';

  const AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: DefaultAppBar(title: "Add!"),
      body: Body(),
    );
  }
}
