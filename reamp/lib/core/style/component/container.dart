import 'package:flutter/material.dart';
import 'package:reamp/core/config/theme.dart';

class ContentBox extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool expandWidth;
  final Gradient? gradient;

  const ContentBox({
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
    this.margin,
    this.expandWidth = false,
    this.gradient,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ReampColors.background,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: ReampColors.backgroundBright,
            blurRadius: 12.0,
            offset: const Offset(-15.0, -15.0),
          ),
          BoxShadow(
            color: ReampColors.secondaryAccent,
            blurRadius: 12.0,
            offset: const Offset(15.0, 15.0),
          ),
        ],
        gradient: gradient,
      ),
      width: expandWidth ? double.infinity : null,
      padding: padding,
      margin: margin,
      child: child,
    );
  }
}
