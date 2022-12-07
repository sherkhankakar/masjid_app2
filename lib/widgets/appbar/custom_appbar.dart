import 'package:flutter/material.dart';
import 'package:masjid/constants/app_colors.dart';
import 'package:masjid/constants/app_decorations.dart';
import 'package:masjid/constants/app_values.dart';
import 'package:masjid/widgets/svg_image/svg_image.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback? ontapmenuIcon;
  final VoidCallback? ontapMasjidIcon;
  const CustomAppBar({super.key, this.ontapmenuIcon, this.ontapMasjidIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: AppDecorations.appBarDecoration(),
      height: 50,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              padding: EdgeInsets.zero,
              splashColor: AppColors.transparent,
              highlightColor: AppColors.transparent,
              onPressed: ontapmenuIcon,
              icon: const Icon(
                Icons.menu,
                color: AppColors.primaryColor,
              )),
          GestureDetector(
            onTap: ontapMasjidIcon,
            child: svgImage(
              height: 25,
              path: AssetPaths.masjidIcon,
            ),
          ),
        ],
      ),
    );
  }
}
