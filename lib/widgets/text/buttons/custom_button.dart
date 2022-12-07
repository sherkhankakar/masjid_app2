import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masjid/constants/app_colors.dart';
import 'package:masjid/constants/app_font.dart';
import 'package:masjid/widgets/text/custom_text.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTapFunction;
  final Color? color;
  final double radius;
  final double height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final Color? textColor;
  final TextDecoration? decoration;
  final String? text;
  final double? textSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final double? shadowSpreadRadius;
  final double? shadowBlurRadius;
  final Offset? shadowOffset;
  final Color? borderColor;
  final String? iconPath;
  final Color? shadowColor;

  const CustomButton({
    Key? key,
    this.onTapFunction,
    this.color,
    this.padding,
    this.margin,
    this.radius = 8,
    this.height = 40,
    this.width = 100,
    this.textColor = CupertinoColors.white,
    this.decoration = TextDecoration.none,
    this.fontWeight = FontWeight.normal,
    this.textSize,
    this.text = '',
    this.fontFamily = FontConstants.poppins,
    this.shadowBlurRadius = 1,
    this.shadowSpreadRadius = 0.5,
    this.shadowColor,
    this.borderColor,
    this.iconPath = "",
    this.shadowOffset = const Offset(0, 1),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      child: Material(
        // color: color ?? Palette.primaryColor,
        color: AppColors.transparent,
        borderRadius: BorderRadius.circular(radius),
        child: InkWell(
          onTap: onTapFunction,
          borderRadius: BorderRadius.circular(radius),
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xfffd941a), Color(0xffa05600)],
              ),
            ),
            alignment: Alignment.center,
            child: CustomText(
              text: text,
              fontColor: textColor,
              fontSize: textSize,
              fontFamily: fontFamily,
              fontWeight: fontWeight!,
            ),
          ),
        ),
      ),
    );
  }
}
