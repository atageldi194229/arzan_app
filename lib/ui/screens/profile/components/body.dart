import 'package:cached_network_image/cached_network_image.dart';
import 'package:tm/core/api/models/user.dart';
import 'package:tm/core/providers/account_provider.dart';
import 'package:tm/ui/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tm/ui/size_config.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    UserModel? user = context.watch<AccountProvider>().user;

    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    debugPrint("User fetched userId: ${user.id}");

    return SingleChildScrollView(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: Stack(
              children: [
                Container(
                  width: _size.width,
                  height: _size.height / 3,
                  color: Colors.green,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        'assets/images/logo_ticket.png',
                        width: getProportionateScreenWidth(100),
                      ),
                      Text(
                        "Arzan",
                        style: TextStyle(
                          fontFamily: 'Arista',
                          fontSize: getProportionateScreenWidth(40),
                          color: Colors.white, // aPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "ÝURDUMYZYŇ ÄHLI KÜNJEGINDE",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(15),
                          color: Colors.white,
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                      const Spacer(flex: 5),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: _size.width,
            height: _size.height * 1.2,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenWidth(100),
                    horizontal: getProportionateScreenHeight(40),
                  ),
                  child: Positioned(
                    top: _size.height / 3,
                    child: Stack(
                      children: [
                        Container(
                          width: _size.width,
                          margin: const EdgeInsets.symmetric(horizontal:5, vertical: 90),
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 12,
                            left: 10,
                            right: 10,
                            bottom: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: kBoxShadow,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: getProportionateScreenHeight(30)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    user.username,
                                    // "user.username",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: kSoftGreen,
                                  ),
                                  Text(
                                    'Asgabat',
                                    style: Theme.of(context).textTheme.subtitle1,
                                  )
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      user.followerCount.toString(), // '291',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 27,
                                      ),
                                    ),
                                    Text(
                                      'Followers',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(color: Colors.grey),
                                    )
                                  ],
                                ),
                              ),
                              Visibility(
                                visible:
                                    !(user.about == null || user.about!.isEmpty),
                                child: Column(
                                  children: [
                                    Text(
                                      user.about.toString(),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 80, 78, 78),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: kDilegSizedBox),
                                  ],
                                ),
                              ),

                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: getProportionateScreenWidth(13),
                                      vertical: getProportionateScreenHeight(12),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ProfileSteps(
                                          text: 'Favorite',
                                          count: 64,
                                          icon: Icons.bookmark_border_outlined,
                                          press: () {},
                                        ),
                                        ProfileSteps(
                                          text: 'Likeded',
                                          count: 43,
                                          icon: Icons.favorite_border,
                                          press: () {},
                                        ),
                                        ProfileSteps(
                                          text: 'Pending',
                                          count: 23,
                                          icon: Icons.timelapse,
                                          press: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ProfileSteps(
                                        text: 'Confirmed',
                                        count: 21,
                                        icon: Icons.confirmation_num,
                                        press: () {},
                                      ),
                                      ProfileSteps(
                                        text: 'Followings',
                                        count: 34,
                                        icon: Icons.person,
                                        press: () {},
                                      ),
                                    ],
                                  )
                                ],
                              ),

                              const SizedBox(height: 25),
                              // const SubscribeButton()
                            ],
                          ),
                        ),
                          Stack(
                            clipBehavior:Clip.none,
                            children: [
                               Positioned(
                                top: SizeConfig.screenWidth * 0.12,
                                left: 10 ,
                                child: const Icon(
                                
                                 Icons.add_box,
                                color: Colors.green,
                                ),
                              ),
                              Positioned(
                              left: SizeConfig.screenWidth * 0.3,
                              top: SizeConfig.screenWidth * 0.1,
                              child: Container(
                                height: _size.width / 4,
                                decoration: const BoxDecoration(
                                
                                  color: kSoftGreen,
                                  shape: BoxShape.circle,
                                ),
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    Widget _placeholder = Icon(
                                      Icons.person_outline_outlined,
                                      size: constraints.biggest.height,
                                      color: Colors.white,
                                    );
                              
                                    if (user.image == null || user.image!.isEmpty) {
                                      return _placeholder;
                                    }
                              
                                    return CircleAvatar(
                                      
                                      maxRadius: constraints.biggest.height / 2,
                                      backgroundImage:
                                          CachedNetworkImageProvider(user.image!),
                                      // foregroundImage: CachedNetworkImageProvider(user.image!),
                                    );
                                  },
                                ),
                              ),
                              ),
                              Container()
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
             
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ProfileSteps extends StatelessWidget {
  final String text;
  final int? count;
  final IconData icon;
  final Function? press;
  const ProfileSteps(
      {Key? key,
      required this.text,
      required this.icon,
      this.press,
      this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => press,
      child: Column(
        children: [
          Icon(icon, color: Colors.green),
          Text(
            text,
            style: const TextStyle(
                color: Color.fromARGB(255, 112, 111, 111),
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3,
                fontSize: 17),
          ),
          Text(count.toString(),
              style: const TextStyle(
                color: Color.fromARGB(255, 78, 76, 76),
                fontWeight: FontWeight.w900,
                fontSize: 19,
              ))
        ],
      ),
    );
  }
}
