import 'package:tm/ui/screens/about_us/about_us_screen.dart';
import 'package:tm/ui/screens/add_post/add_post_screen.dart';
import 'package:tm/ui/screens/login/login_screen.dart';
import 'package:tm/ui/screens/notification_detail/notification_detail_screen.dart';
import 'package:tm/ui/screens/notifications/notifications_screen.dart';
import 'package:tm/ui/screens/official_users/official_users_screen.dart';
import 'package:tm/ui/screens/payment/components/payment_screen/fourth_payment_step.dart';
import 'package:tm/ui/screens/payment/components/payment_screen/second_payment_step.dart';
import 'package:tm/ui/screens/payment/components/payment_screen/success_screen.dart';
import 'package:tm/ui/screens/payment/components/payment_screen/third_payment_step.dart';
import 'package:tm/ui/screens/payment/payment_screen.dart';
import 'package:tm/ui/screens/profile/profile_screen.dart';
import 'package:tm/ui/screens/register/register_screen.dart';
import 'package:tm/ui/screens/search/search_screen.dart';
import 'package:tm/ui/screens/settings/settings_screen.dart';
import 'package:tm/ui/screens/statistics/statistics_screen.dart';
import 'package:tm/ui/screens/test_screen/test_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:tm/ui/screens/splash/splash_screen.dart';
import 'package:tm/ui/screens/sign_in/sign_in_screen.dart';
import 'package:tm/ui/screens/login_success/login_success_screen.dart';
import 'package:tm/ui/screens/home/home_screen.dart';
import 'package:tm/ui/screens/select_region/select_region_screen.dart';

import 'screens/contact_us/contact_us_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  TestScreen.routeName: (context) => const TestScreen(),
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  LoginSuccessScreen.routeName: (context) => const LoginSuccessScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  SelectRegion.routeName: (context) => const SelectRegion(),
  SettingsScreen.routeName: (context) => const SettingsScreen(),
  // PostDetailScreen.routeName: (context) => const PostDetailScreen(),
  ProfileScreen.routeName: ((context) => const ProfileScreen()),
  SearchScreen.routeName: (context) => const SearchScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  AboutUsScreen.routeName: (context) => const AboutUsScreen(),
  StatisticsScreen.routeName: ((context) => const StatisticsScreen()),
  NotificationsScreen.routeName: ((context) => const NotificationsScreen()),
  OfficialUsersScreen.routeName: ((context) => const OfficialUsersScreen()),
  ContactUsScreen.routeName: ((context) => const ContactUsScreen()),
  RegisterScreen.routeName: ((context) => const RegisterScreen()),
  AddPostScreen.routeName: ((context) => const AddPostScreen()),
  NotificationDetailScreen.routeName: ((context) =>
      const NotificationDetailScreen()),

  //payment screen
  PaymentScreen.routeName: ((context) => const PaymentScreen()),
  SecondPaymentScreen.routeName: ((context) => const SecondPaymentScreen()),
  ThirdPaymentScreen.routeName: (context) => const ThirdPaymentScreen(),
  FourthPaymentScreen.routeName: (context) => const FourthPaymentScreen(),
  SuccessPaymentScreen.routeName: (context) => const SuccessPaymentScreen()
};
