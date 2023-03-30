import 'package:flutter/material.dart';
import 'package:reamp/core/style/component/buttons.dart';
import 'package:reamp/core/style/component/container.dart';
import 'package:reamp/core/style/layout/general.dart';

class OnboardingLayout extends StatelessWidget {
  final Widget child;
  final String title;
  final Function()? onPressed;
  final bool padding;
  final bool showBox;

  const OnboardingLayout({
    required this.title,
    required this.onPressed,
    required this.child,
    this.padding = true,
    this.showBox = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GeneralLayout(
      showBackButton: true,
      title: title,
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (showBox) ContentBox(
            padding: const EdgeInsets.all(32.0),
            child: child,
          ) else child,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: PrimaryButton(
              onPressed: onPressed,
              child: const Text("Bestätigen"),
            ),
          ),
        ],
      ),
    );
  }
}