import 'package:flutter/material.dart';
import '../../components/officalUsers.dart';
import '../../constants.dart';
import '../../widgets/default_appbar.dart';
 

class OfficialUsersScreen extends StatelessWidget {
  static const routeName = '/official_users';
  const OfficialUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
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
                titlePadding: const EdgeInsets.symmetric(horizontal: 10),
                title: FittedBox(
                  child: SizedBox(
                    width: _size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '6',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Container(
                          padding: EdgeInsets.all(4),
                          child: Center(
                              child: Icon(
                            Icons.grid_view_rounded,
                            color: kSoftGreen,
                          )),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 9.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: kBoxShadow,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        // Divider()
                      ],
                    ),
                  ),
                )),
          ),
          SliverToBoxAdapter(
            child: GridView.builder(
                itemCount: 20,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.65,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) => OfficalUsers(
                      iconShow: true,
                    )),
          )
        ],
      ),
    );
  }
}
