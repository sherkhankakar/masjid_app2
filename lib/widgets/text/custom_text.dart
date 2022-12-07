import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_font.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? height;
  final int? maxLines;
  final double? width;
  final bool enableShadow;
  final TextAlign? textAlign;
  final FontWeight fontWeight;
  final TextDecoration? decoration;
  final double? fontSize;
  final double fontSizeArabic;
  final String? fontFamily;
  final FontStyle? style;
  final TextOverflow overflow;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  final Color? fontColor;
  const CustomText({
    Key? key,
    this.text = '',
    this.height = 1,
    this.width,
    this.textAlign,
    this.fontSizeArabic = FontSize.s10,
    this.enableShadow = false,
    this.padding,
    this.margin,
    this.maxLines,
    this.fontWeight = FontWeight.normal,
    this.fontSize = FontSize.s16,
    this.fontColor = AppColors.textColorBlack,
    this.decoration = TextDecoration.none,
    this.style = FontStyle.normal,
    this.fontFamily = FontConstants.lato,
    this.overflow = TextOverflow.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      width: width,
      child: Text(
        text!,
        // text!.capitalize(),
        // maxLines: 1,
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: overflow,
        style: TextStyle(
            shadows: enableShadow
                ? const [
                    Shadow(
                      offset: Offset(2, 2),
                      blurRadius: 3,
                      color: AppColors.black,
                    )
                  ]
                : null,
            height: height,
            fontSize: fontSize,
            color: fontColor,
            fontWeight: fontWeight,
            decoration: decoration,
            fontStyle: style,
            fontFamily: fontFamily),
      ),
    );
  }
}
