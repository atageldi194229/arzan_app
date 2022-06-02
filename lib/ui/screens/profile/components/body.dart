import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:tm/core/api/models/post_model.dart';
import 'package:tm/core/api/models/user.dart';
import 'package:tm/core/providers/account_provider.dart';
import 'package:tm/core/providers/auth_provider.dart';
import 'package:tm/core/providers/banner_provider.dart';
import 'package:tm/ui/components/official_user.dart';
import 'package:tm/ui/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tm/ui/screens/post_detail/components/constants.dart';
import 'package:tm/ui/screens/post_detail/post_detail_screen.dart';
import 'package:tm/ui/screens/profile/profile_screen.dart';
import 'package:tm/ui/screens/profile_setting/profile_setting_screen.dart';
import 'package:tm/ui/widgets/post_card.dart';

class Body extends StatefulWidget {
  final ProfileScreenState parentState;

  const Body({
    Key? key,
    required this.parentState,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final ScrollController controller = ScrollController();

  final List<_CountButton> countButtons = <_CountButton>[
    _CountButton(_CountButtonType.liked, "Liked", 748),
    _CountButton(_CountButtonType.followers, "Followers", 654),
    _CountButton(_CountButtonType.followings, "Followings", 599),
    _CountButton(_CountButtonType.confirmed, "Confirmed", 782),
    _CountButton(_CountButtonType.favorites, "Favorites", 135),
    _CountButton(_CountButtonType.pending, "Pending", 456),
  ];

  int selectedCountButtonIndex = 0;

  @override
  void initState() {
    super.initState();

    // Setup the listener.
    controller.addListener(() {
      if (!controller.hasClients) return;

      if (controller.position.atEdge) {
        bool isTop = controller.position.pixels == 0;
        if (!isTop) {
          switch (selectedCountButton.type) {
            case _CountButtonType.followings:
              widget.parentState.loadFollowings();
              break;

            case _CountButtonType.followers:
              widget.parentState.loadFollowers();
              break;

            case _CountButtonType.confirmed:
              widget.parentState.loadConfirmed();
              break;

            case _CountButtonType.pending:
              widget.parentState.loadPending();
              break;

            case _CountButtonType.favorites:
              widget.parentState.loadFavorites();
              break;

            case _CountButtonType.liked:
              widget.parentState.loadLiked();
              break;
            default:
          }
        }
      }
    });
  }

  _CountButton get selectedCountButton =>
      countButtons[selectedCountButtonIndex];

  @override
  Widget build(BuildContext context) {
    var banners = context.watch<BannerProvider>().banners;
    String bannerImage =
        "https://arzan.info:3021/api/uploads/banners/131/d60667cc-860b-4f01-889c-a33aa5deeb56.jpg";
    if (banners.isNotEmpty) bannerImage = banners[0].image;

    var followerList = widget.parentState.followerList;
    var followingList = widget.parentState.followingList;
    var likedList = widget.parentState.likedList;
    var confirmedList = widget.parentState.confirmedList;
    var favoriteList = widget.parentState.favoriteList;
    var pendingList = widget.parentState.pendingList;

    countButtons[1].count = followerList.count;
    countButtons[2].count = followingList.count;
    countButtons[0].count = likedList.count;
    countButtons[3].count = confirmedList.count;
    countButtons[4].count = favoriteList.count;
    countButtons[5].count = pendingList.count;

    late Widget itemListWidget;

    switch (selectedCountButton.type) {
      case _CountButtonType.followings:
        itemListWidget = _buildUserList(
          context,
          users: widget.parentState.followingList.list,
        );
        break;

      case _CountButtonType.followers:
        itemListWidget = _buildUserList(
          context,
          users: widget.parentState.followerList.list,
        );
        break;

      case _CountButtonType.confirmed:
        itemListWidget = _buildPostList(
          context,
          posts: confirmedList.list,
          loadPosts: widget.parentState.loadConfirmed,
        );
        break;

      case _CountButtonType.pending:
        itemListWidget = _buildPostList(
          context,
          posts: pendingList.list,
          loadPosts: widget.parentState.loadPending,
        );
        break;

      case _CountButtonType.favorites:
        itemListWidget = _buildPostList(
          context,
          posts: favoriteList.list,
          loadPosts: widget.parentState.loadFavorites,
        );
        break;

      case _CountButtonType.liked:
        itemListWidget = _buildPostList(
          context,
          posts: likedList.list,
          loadPosts: widget.parentState.loadLiked,
        );
        break;
      default:
        itemListWidget = Container();
    }

    Size size = MediaQuery.of(context).size;

    var authProvider = context.watch<AuthProvider>();
    var accountProvider = context.watch<AccountProvider>();

    UserModel? user = accountProvider.user;

    debugPrint("PROFILE: ${authProvider.isLoggedIn} ${user == null}");

    if (!authProvider.isLoggedIn || user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    double bannerHeight = size.width * 0.7;
    double avatarLogoSize = size.width * 0.3;
    double starIconSize = avatarLogoSize * 0.2;

    return SafeArea(
      child: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: bannerHeight,
                      color: kSoftGreen,
                      child: CachedNetworkImage(
                        imageUrl: bannerImage,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            height: avatarLogoSize / 2,
                            margin: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                SizedBox(
                                  // color: kSoftGreen,
                                  width: 40,
                                  height: 40,
                                ),
                                Spacer(),
                                SizedBox(
                                  // color: kSoftGreen,
                                  width: 40,
                                  height: 40,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0 * 2),
                            child: Column(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Center(
                                    child: Text(
                                      user.username,
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.location_on_outlined,
                                        color: kTextColor,
                                      ),
                                      Text(
                                        "Ahal, Ashgabat",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(color: kTextColor),
                                      ),
                                    ],
                                  ),
                                ),
                                if (user.about != null)
                                  Container(
                                    margin: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      user.about ?? "",
                                      //                                     """Lorem ipsum dolor, sit amet consectetur adipisicing elit. Voluptatum sed, autem voluptas assumenda dolorum tempore in quae impedit quod! Dolore rerum quam tempora corporis tenetur dicta aperiam perspiciatis, laborum magni?
                                      // Eius eligendi at temporibus accusamus odio ducimus? Est accusantium expedita fugit tenetur provident, nesciunt amet quam. Sint, facere architecto voluptas adipisci dolorum, corrupti provident nostrum dolorem possimus temporibus saepe quis.""",
                                      style: const TextStyle(color: kTextColor),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          _buildCountButtons(context),
                          itemListWidget,
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 30,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: const Icon(
                            Icons.arrow_back,
                            size: iconSize * 1.5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(ProfileSettingScreen.routeName);
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: kSoftGreen,
                                blurRadius: 30,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: const Icon(
                            Icons.settings,
                            size: iconSize * 1.5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: bannerHeight - avatarLogoSize / 2,
                  left: size.width / 2 - avatarLogoSize / 2,
                  child: _AvatarLogo(
                    user.image,
                    size: avatarLogoSize,
                  ),
                ),
                Positioned(
                  top: bannerHeight + avatarLogoSize / 2 - starIconSize / 2,
                  left: size.width / 2 - starIconSize / 2,
                  child: Image.asset(
                    'assets/images/official_icon.png',
                    width: starIconSize,
                    height: starIconSize,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildCountButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0 * 2),
      child: LayoutBuilder(builder: ((context, constraints) {
        double childWidth = constraints.maxWidth / 3;

        return Wrap(
          children: [
            ...List.generate(
              countButtons.length,
              (index) => SizedBox(
                width: childWidth,
                child: _buildCountButton(
                  context,
                  text: countButtons[index].text,
                  count: countButtons[index].count,
                  active: selectedCountButtonIndex == index,
                  onTap: () {
                    setState(() {
                      selectedCountButtonIndex = index;
                    });
                  },
                ),
              ),
            ),
          ],
        );
      })),
    );
  }

  _buildCountButton(
    BuildContext context, {
    void Function()? onTap,
    int count = 0,
    required String text,
    bool active = false,
  }) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                count.toString(),
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: kTextColor),
              ),
              Center(
                child: LayoutBuilder(builder: (context, constraints) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: active ? constraints.maxWidth : 0,
                    height: 1,
                    color: Colors.black,
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildUserList(
    BuildContext context, {
    required List<UserModel> users,
  }) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8.0),
      itemCount: users.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.65,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemBuilder: (context, index) => OfficialUser(
        users[index],
        iconShow: false,
      ),
    );
  }

  _buildPostList(
    BuildContext context, {
    required List<PostModel> posts,
    Function? loadPosts,
  }) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: posts.length,
      itemBuilder: (context, index) => PostCard(
        post: posts[index],
        onTap: () {
          Navigator.pushNamed(
            context,
            PostDetailScreen.routeName,
            arguments: PostDetailScreenArguments(
              posts: posts,
              defaultIndex: index,
              loadPosts: loadPosts,
            ),
          );
        },
      ),
    );
  }
}

class _AvatarLogo extends StatelessWidget {
  final String image;
  final double size;
  const _AvatarLogo(
    this.image, {
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        // color: kSoftGreen,
        shape: BoxShape.circle,
      ),
      child: CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
      ),
    );
  }
}

enum _CountButtonType {
  liked,
  followers,
  followings,
  confirmed,
  favorites,
  pending
}

class _CountButton {
  int count;
  String text;
  final _CountButtonType type;

  _CountButton(this.type, this.text, this.count);
}
