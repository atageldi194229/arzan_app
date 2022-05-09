import 'package:tm/ui/constants.dart';
import 'package:tm/ui/widgets/default_appbar.dart';
import 'package:flutter/material.dart';

class OfficialUsersScreen extends StatelessWidget {
  static const routeName = '/official_users';
  const OfficialUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: _size.height / 8,
            automaticallyImplyLeading: false,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: const DefaultAppBar(title: 'Official users'),
                centerTitle: true,
                title: FittedBox(
                  child: SizedBox(
                    width: _size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('6',
                              style: Theme.of(context).textTheme.headline6),
                        ],
                      ),
                    ),
                  ),
                )),
          ),
          SliverToBoxAdapter(
            child: GridView.builder(
                itemCount: 6,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 0.55),
                itemBuilder: (context, index) => const UserBlock()),
          )
        ],
      ),
    );
  }
}

class UserBlock extends StatefulWidget {
  const UserBlock({Key? key}) : super(key: key);

  @override
  State<UserBlock> createState() => _UserBlockState();
}

class _UserBlockState extends State<UserBlock> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {},
      child: Container(
        height: _size.height,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: FadeInImage.assetNetwork(
                placeholder: imagePlaceholder,
                image:
                    'https://m.media-amazon.com/images/I/61iR9NMcKpL._UL1280_.jpg',
                fit: BoxFit.cover,
              ),
            ),
            // const Expanded(flex: 2, child: UserCircle()),
            Expanded(
                child: Column(
              children: const [
                Text('Name Surname'),
                SizedBox(height: 10),
                SubscribeButton()
              ],
            )),
          ],
        ),
      ),
    );
  }
}

class SubscribeButton extends StatefulWidget {
  const SubscribeButton({Key? key}) : super(key: key);

  @override
  State<SubscribeButton> createState() => _SubscribeButtonState();
}

class _SubscribeButtonState extends State<SubscribeButton> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isTapped = !isTapped;
        });
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
              color: isTapped ? Colors.grey : kSoftGreen,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(color: Colors.grey, blurRadius: 5, spreadRadius: .5)
              ]),
          child: Text(
            isTapped ? 'Subscribed' : 'Subscribe',
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
  }
}
