import 'package:provider/provider.dart';
import 'package:tm/core/localization/index.dart';
import 'package:tm/core/providers/region_status_provider.dart';

import './notification_provider.dart';
import './post_search_provider.dart';
import './post_detail_provider.dart';
import './auth_provider.dart';
import './home_screen_provider.dart';
import './banner_provider.dart';
import './recommended_post_provider.dart';
import './account_provider.dart';
import './official_user_list_provider.dart';

List<ChangeNotifierProvider> providers = [
  ChangeNotifierProvider<LangProvider>(create: (context) => LangProvider()),
  ChangeNotifierProvider<HomeScreenProvider>(
      create: (context) => HomeScreenProvider()),
  ChangeNotifierProvider<BannerProvider>(create: (context) => BannerProvider()),
  ChangeNotifierProvider<RecommendedPostProvider>(
      create: (context) => RecommendedPostProvider()),
  ChangeNotifierProvider<PostDetailProvider>(
      create: (context) => PostDetailProvider()),
  ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
  ChangeNotifierProvider<AccountProvider>(
      create: (context) => AccountProvider()),
  ChangeNotifierProvider<NotificationProvider>(
      create: (context) => NotificationProvider()),
  ChangeNotifierProvider<PostSearchProvider>(
      create: (context) => PostSearchProvider()),
  ChangeNotifierProvider<RegionStatusProvidor>(
      create: (context) => RegionStatusProvidor()),
  ChangeNotifierProvider<OfficialUserListProvider>(
      create: (context) => OfficialUserListProvider()),
];
