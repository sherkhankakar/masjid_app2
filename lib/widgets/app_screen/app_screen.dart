import 'package:flutter/material.dart';

class AppScreen extends StatelessWidget {
  final Widget child;
  final Alignment alignment;
  final double verticalPadding;
  final double horizontalPadding;
  const AppScreen({
    Key? key,
    this.horizontalPadding = 0.0,
    this.verticalPadding = 0.0,
    this.alignment = Alignment.center,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
