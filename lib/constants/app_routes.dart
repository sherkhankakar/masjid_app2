import 'package:flutter/material.dart';
import 'package:masjid/screens/screen_home.dart';
import 'package:masjid/screens/splash.dart';

class OurRoutes {
  static const String initialRoute = "/";
  static const String splashRoute = "/splash";
  static const String home = "/home";
}

tabRoutes(navKey, Widget initialRoute) => {
      OurRoutes.initialRoute: (context) => initialRoute,
      OurRoutes.splashRoute: (context) => const Splash(),
      OurRoutes.home: (context) => const ScreenHome(),
    };
