import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masjid/constants/app_colors.dart';

Widget svgImage({
  required String path,
  BoxFit fit = BoxFit.cover,
  double width = 20,
  double height = 20,
  Color iconColor = AppColors.primaryColor,
}) {
  return SvgPicture.asset(
    path,
    fit: fit,
    width: width,
    color: iconColor,
    height: height,
  );
}
