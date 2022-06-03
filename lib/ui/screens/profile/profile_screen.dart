import 'package:flutter/material.dart';

import 'package:tm/core/api/models/count_and_list_model.dart';
import 'package:tm/core/api/models/index.dart';
import 'package:tm/core/api/services/account_service.dart';
import 'package:tm/core/api/services/post_service.dart';
import 'package:tm/ui/constants.dart';
import 'package:tm/ui/helper/flutter_3_ambiguate.dart';
import 'package:tm/ui/screens/profile/components/body.dart';
import 'package:tm/ui/screens/profile/components/loading_widget.dart';
import 'package:tm/ui/screens/profile/components/try_again.dart';

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
  UserModel? user;
  bool loadFailed = false;

  ItemPaginationModel<UserModel> followingList = ItemPaginationModel();
  ItemPaginationModel<UserModel> followerList = ItemPaginationModel();
  ItemPaginationModel<PostModel> likedList = ItemPaginationModel();
  ItemPaginationModel<PostModel> confirmedList = ItemPaginationModel();
  ItemPaginationModel<PostModel> favoriteList = ItemPaginationModel();
  ItemPaginationModel<PostModel> pendingList = ItemPaginationModel();

  tryLoadUser() {
    final args =
        ModalRoute.of(context)!.settings.arguments as ProfileScreenArguments;

    args.loadUser().then((user) {
      setState(() {
        this.user = user;
      });

      loadFollowings();
      loadFollowers();
      loadConfirmed();
      loadFavorites();
      loadPending();
      loadLiked();
    }).catchError((_) async {
      setState(() {
        loadFailed = true;
      });
      debugPrint("Error when loading user in UserScreen");
    });
  }

  @override
  void initState() {
    super.initState();

    ambiguate(WidgetsBinding.instance)!.addPostFrameCallback((_) {
      tryLoadUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ProfileScreenArguments;

    Widget body = const LoadingWidget();

    if (loadFailed) {
      loadFailed = false;
      body = TryAgain(onPressed: () => tryLoadUser());
    }

    if (user != null) {
      body = Body(
        parentState: this,
        user: user!,
        mode: args.mode,
      );
    }

    return Scaffold(
      backgroundColor: kScaffoldColor,
      body: body,
      extendBody: true,
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.profile),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: const CustomFloatingActionButton(),
      drawer: const CustomDrawer(),
    );
  }

  loadFollowings() async {
    try {
      CountAndListModel<UserModel> result =
          await AccountService().getFollowings(
        userId: user!.id,
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
        userId: user!.id,
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
        userId: user!.id,
        limit: likedList.limit,
        offset: likedList.offset,
        filter: "liked",
      );

      var list = result.list.map((e) {
        e.isLike = true;
        return e;
      }).toList();

      likedList
        ..setCount(result.count)
        ..addAll(list);
    } catch (error) {
      debugPrint(error.toString());
    }

    setState(() {});
  }

  loadPending() async {
    try {
      CountAndListModel<PostModel> result = await PostService().getUserPosts(
        userId: user!.id,
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
        userId: user!.id,
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
        userId: user!.id,
        limit: favoriteList.limit,
        offset: favoriteList.offset,
        filter: "favorites",
      );

      var list = result.list.map((e) {
        e.isFavorite = true;
        return e;
      }).toList();

      favoriteList
        ..setCount(result.count)
        ..addAll(list);
    } catch (error) {
      debugPrint(error.toString());
    }

    setState(() {});
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

class ProfileScreenArguments {
  final ProfileScreenMode mode;
  final Future<UserModel> Function() loadUser;

  ProfileScreenArguments({
    this.mode = ProfileScreenMode.official,
    required this.loadUser,
  });
}
