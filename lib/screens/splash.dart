import 'dart:async';

import 'package:flutter/material.dart';
import 'package:masjid/constants/app_colors.dart';
import 'package:masjid/constants/app_font.dart';
import 'package:masjid/constants/app_routes.dart';
import 'package:masjid/constants/app_strings.dart';
import 'package:masjid/constants/navigator.dart';
import 'package:masjid/constants/sizes.dart';
import 'package:masjid/widgets/app_screen/app_screen.dart';
import 'package:masjid/widgets/text/custom_text.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      navigateAndRemove(OurRoutes.home);
    });
    return AppScreen(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CustomText(
            fontFamily: FontConstants.poppins,
            fontColor: AppColors.primaryColor,
            text: "Jazak Allah",
            fontSize: 27,
            fontWeight: FontWeight.bold,
          ),
          gap(height: 10),
          const CustomText(
            fontFamily: FontConstants.poppins,
            fontColor: AppColors.whiteWithOpacy77,
            text: "اے اللہ! میرے لیے رحمت کے دروازے کھول دے۔",
            fontSize: 13,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
