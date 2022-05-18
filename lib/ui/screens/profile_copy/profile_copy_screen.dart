import 'package:tm/core/api/models/user.dart';
import 'package:tm/core/providers/account_provider.dart';
import 'package:tm/ui/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    UserModel? user = context.watch<AccountProvider>().user;

    if (user == null) {
      return const Text("Downoloading");
    }

    return SingleChildScrollView(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              width: _size.width,
              height: _size.height / 3,
              color: Colors.green,
            ),
          ),
          SizedBox(
            width: _size.width,
            height: _size.height,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: _size.height / 4,
                  child: Container(
                    width: _size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 12,
                        left: 10,
                        right: 10,
                        bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(user.username,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(fontWeight: FontWeight.bold)),
                            const Icon(
                              Icons.edit,
                              color: kSoftGreen,
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
                                '12',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'SUBSCRIBERS',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: const [
                                  Text('12',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text('Likes')
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.grey.shade200,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  children: const [
                                    Text('12',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('Followings')
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: const [
                                  Text('12',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text('Favorites')
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: const [
                                  Text('12',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text('Confirmed')
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: const [
                                  Text('12',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text('Pending')
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        // const SubscribeButton()
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: _size.height / 5,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: _size.width / 4,
                    decoration: const BoxDecoration(
                        color: kSoftGreen, shape: BoxShape.circle),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Icon(
                          Icons.account_circle_outlined,
                          size: constraints.biggest.height,
                          color: Colors.white,
                        );
                      },
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
