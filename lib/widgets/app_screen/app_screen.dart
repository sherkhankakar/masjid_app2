import 'package:flutter/material.dart';
import 'package:masjid/widgets/text/custom_text.dart';

class AppScreen extends StatelessWidget {
  final Widget child;
  final GlobalKey? scaffoldKey;
  final Widget? drawer;
  final Alignment alignment;
  final double verticalPadding;
  final double horizontalPadding;

  const AppScreen({
    Key? key,
    this.drawer,
    this.scaffoldKey,
    this.horizontalPadding = 0.0,
    this.verticalPadding = 0.0,
    this.alignment = Alignment.center,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: drawer,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding,
            horizontal: horizontalPadding,
          ),
          alignment: alignment,
          child: child,
        ),
      ),
    );
  }
}
