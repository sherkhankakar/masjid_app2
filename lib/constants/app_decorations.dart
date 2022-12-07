import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppDecorations {
  static final commonShadow = [
    BoxShadow(
      color: Colors.grey.withOpacity(0.7),
      // spreadRadius: 1,
      blurRadius: 60,
      offset: const Offset(25, 25), // changes position of shadow
    ),
  ];

  static const commonShadowDecoration = BoxDecoration();

  static LinearGradient borderGradient = const LinearGradient(
    colors: [AppColors.whiteWithOpacy77, Color(0xffa05600)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient errorGradient = LinearGradient(
    colors: [AppColors.whiteWithOpacy77, Color(0xfff44336)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient commonGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xfffd941a), Color(0xffa05600)],
  );
  static const LinearGradient greenGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xff8ABB2A), Color(0xff405B05)],
  );
  static const LinearGradient redGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xfff44336), Color(0xffd32f2f)],
  );
  static const LinearGradient purpleGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xff512da8), Color(0xff311b92)],
  );

  static const LinearGradient whiteGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xffffffff), Color(0xffacaaaa)],
  );

  static roundedDecoration({
    Color color = AppColors.white,
    double radius = 4,
    double spreadRadius = 2,
    double blurRadius = 4,
    Offset? offset,
    Color? shadowColor,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: AppDecorations.myShadow(spreadRadius: spreadRadius, blurRadius: blurRadius, color: shadowColor, offset: offset),
    );
  }

  static appBarDecoration({
    Color color = AppColors.darkGrey,
    double radius = 7,
    double spreadRadius = 2,
    double blurRadius = 4,
    Offset? offset,
    Color? shadowColor,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(radius),
        bottomRight: Radius.circular(radius),
      ),
      boxShadow: AppDecorations.myShadow(
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
        color: shadowColor,
        offset: offset,
      ),
    );
  }

  static List<BoxShadow> myShadow({
    double spreadRadius = 2,
    double blurRadius = 4,
    Offset? offset,
    Color? color,
  }) {
    return [
      BoxShadow(
        color: color ?? Colors.grey.withOpacity(0.3),
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
        offset: offset ??= Offset(0, 1),
      )
    ];
  }

  static final lightShadow = [
    BoxShadow(
      color: AppColors.black.withOpacity(0.09),
      spreadRadius: 0.5,
      blurRadius: 0.5,
      offset: const Offset(0, 1), // changes position of shadow
    ),
  ];
  static final showItem = BoxShadow(
    color: Colors.grey.withOpacity(0.3),
    spreadRadius: 1,
    blurRadius: 0.5,
    offset: const Offset(0, 1), // changes position of shadow
  );
}
