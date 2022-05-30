import 'package:provider/provider.dart';
import 'package:tm/core/api/models/count_and_list_model.dart';
import 'package:tm/core/api/models/index.dart';
import 'package:tm/core/api/services/account_service.dart';
import 'package:tm/core/api/services/post_service.dart';
import 'package:tm/core/providers/account_provider.dart';
import 'package:tm/core/providers/auth_provider.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/screens/profile/components/body.dart';
import 'package:flutter/material.dart';

import '../../enums.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/custom_floating_action_button.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = '/profile';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  ItemPaginationModel<UserModel> followingList = ItemPaginationModel();
  ItemPaginationModel<UserModel> followerList = ItemPaginationModel();
  ItemPaginationModel<PostModel> likedList = ItemPaginationModel();
  ItemPaginationModel<PostModel> confirmedList = ItemPaginationModel();
  ItemPaginationModel<PostModel> favoriteList = ItemPaginationModel();
  ItemPaginationModel<PostModel> pendingList = ItemPaginationModel();

  int _userId = 0;

  loadFollowings() async {
    try {
      CountAndListModel<UserModel> result =
          await AccountService().getFollowings(
        userId: _userId,
        limit: followingList.limit,
        offset: followingList.offset,
      );

      followingList
        ..setCount(result.count)
        ..addAll(result.list);
    } catch (error) {
      debugPrint(error.toString());
    }

    setState(() {});
  }

  loadFollowers() async {
    try {
      CountAndListModel<UserModel> result = await AccountService().getFollowers(
        userId: _userId,
        limit: followerList.limit,
        offset: followerList.offset,
      );

      followerList
        ..setCount(result.count)
        ..addAll(result.list);
    } catch (error) {
      debugPrint(error.toString());
    }

    setState(() {});
  }

  loadLiked() async {
    try {
      CountAndListModel<PostModel> result = await PostService().getUserPosts(
        userId: _userId,
        limit: likedList.limit,
        offset: likedList.offset,
        filter: "liked",
      );

      likedList
        ..setCount(result.count)
        ..addAll(result.list);
    } catch (error) {
      debugPrint(error.toString());
    }

    setState(() {});
  }

  loadPending() async {
    try {
      CountAndListModel<PostModel> result = await PostService().getUserPosts(
        userId: _userId,
        limit: pendingList.limit,
        offset: pendingList.offset,
        filter: "pending",
      );

      pendingList
        ..setCount(result.count)
        ..addAll(result.list);
    } catch (error) {
      debugPrint(error.toString());
    }

    setState(() {});
  }

  loadConfirmed() async {
    try {
      CountAndListModel<PostModel> result = await PostService().getUserPosts(
        userId: _userId,
        limit: confirmedList.limit,
        offset: confirmedList.offset,
        filter: "confirmed",
      );

      confirmedList
        ..setCount(result.count)
        ..addAll(result.list);
    } catch (error) {
      debugPrint(error.toString());
    }

    setState(() {});
  }

  loadFavorites() async {
    try {
      CountAndListModel<PostModel> result = await PostService().getUserPosts(
        userId: _userId,
        limit: favoriteList.limit,
        offset: favoriteList.offset,
        filter: "favorites",
      );

      favoriteList
        ..setCount(result.count)
        ..addAll(result.list);
    } catch (error) {
      debugPrint(error.toString());
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    AuthProvider auth = context.read<AuthProvider>();
    context.read<AccountProvider>().initUser(
          userId: auth.userId,
        );

    _userId = auth.userId;

    loadFollowings();
    loadFollowers();
    loadConfirmed();
    loadFavorites();
    loadPending();
    loadLiked();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,
      // appBar: DefaultAppBar(title: 'My Profile'),
      body: Body(parentState: this),

      extendBody: true,
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.profile),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: const CustomFloatingActionButton(),
      drawer: const CustomDrawer(),
    );
  }
}

class ItemPaginationModel<T> {
  int count = 0;
  int limit = 15;
  int offset = 0;
  List<T> list = [];

  setLimit(int limit) {
    this.limit = limit;
  }

  setOffset(int offset) {
    this.offset = offset;
  }

  setCount(int count) {
    this.count = count;
  }

  addAll(List<T> list) {
    this.list.addAll(list);
    offset += list.length;
  }
}
