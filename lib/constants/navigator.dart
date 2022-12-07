import 'package:flutter/material.dart';
import 'package:masjid/constants/utils.dart';

navigate(routeName) {
  Navigator.pushNamed(navigatorKey.currentContext!, routeName);
}
navigateAndRemove(routeName) {
  Navigator.pushReplacementNamed(navigatorKey.currentContext!, routeName);
}