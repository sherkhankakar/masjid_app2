import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/material.dart';
import 'package:masjid/constants/app_colors.dart';
import 'package:masjid/constants/app_decorations.dart';
import 'package:masjid/constants/app_font.dart';
import 'package:masjid/constants/app_strings.dart';
import 'package:masjid/constants/app_values.dart';
import 'package:masjid/constants/sizes.dart';
import 'package:masjid/widgets/app_screen/app_screen.dart';
import 'package:masjid/widgets/appbar/custom_appbar.dart';
import 'package:masjid/widgets/svg_image/svg_image.dart';
import 'package:masjid/widgets/text/buttons/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masjid/widgets/text/custom_text.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          CustomAppBar(
            ontapmenuIcon: () {},
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  gap(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.red,
                          child: AnalogClock(
                            height: 170.w,
                            decoration: AppDecorations.roundedDecoration(
                              radius: 100,
                              color: AppColors.darkGrey,
                            ),
                            width: 170.w,
                            isLive: true,
                            hourHandColor: AppColors.primaryColor,
                            minuteHandColor: AppColors.white,
                            showSecondHand: true,
                            numberColor: AppColors.primaryColor,
                            showNumbers: true,
                            showAllNumbers: true,
                            textScaleFactor: 1.4,
                            showTicks: true,
                            showDigitalClock: false,
                            datetime: DateTime(2019, 1, 1, 9, 12, 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
