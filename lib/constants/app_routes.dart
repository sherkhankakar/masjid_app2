import 'package:flutter/material.dart';
import 'package:masjid/screens/add_masjid.dart';
import 'package:masjid/screens/login_screen.dart';
import 'package:masjid/screens/masjid_details.dart';
import 'package:masjid/screens/nearby_masjids.dart';
import 'package:masjid/screens/screen_home.dart';
import 'package:masjid/screens/signup_screen.dart';
import 'package:masjid/screens/splash.dart';

class OurRoutes {
  static const String initialRoute = "/";
  static const String splashRoute = "/splash";
  static const String home = "/home";
  static const String details = "/masjidDetails";
  static const String add = "/addMasjid";
  static const String signup = "/signup";
  static const String login = "/login";
  static const String nearby = "/nearby";
}

tabRoutes(navKey, Widget initialRoute) => {
      OurRoutes.initialRoute: (context) => initialRoute,
      OurRoutes.splashRoute: (context) => const Splash(),
      OurRoutes.home: (context) => const ScreenHome(),
      OurRoutes.details: (context) => MasjidDetails(),
      OurRoutes.add: (context) => const AddMasjid(),
      OurRoutes.signup: (context) => const SignUpScreen(),
      OurRoutes.login: (context) => const LoginScreen(),
      OurRoutes.nearby: (context) => const NearbyMasjids(),
    };
