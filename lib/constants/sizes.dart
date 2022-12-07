import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:masjid/constants/utils.dart';

class Sizes {
  static double h = MediaQuery.of(navigatorKey.currentContext!).size.height;
  static double w = MediaQuery.of(navigatorKey.currentContext!).size.width;

  static bool isMobile() {
    final size = w;
    if (size < 650 || !kIsWeb) {
      return true;
    } else {
      return false;
    }
  }

  static bool isTab() {
    final size = w;
    if (size >= 650) {
      return true;
    } else {
      return false;
    }
  }
}

class AppSizes {
  static const double s5 = 5.0;
  static const double s7 = 7.0;
  static const double s8 = 8.0;
  static const double s10 = 10.0;
  static const double s12 = 12.0;
  static const double s13 = 13.0;
  static const double s14 = 14.0;
  static const double s15 = 15.0;
  static const double s16 = 16.0;
  static const double s17 = 17.0;
  static const double s18 = 18.0;
  static const double s20 = 20.0;
  static const double s22 = 22.0;
  static const double s24 = 24.0;
  static const double s27 = 27.0;
}

gap({double width = 10, double height = 10}) {
  return SizedBox(
    width: width,
    height: height,
  );
}
