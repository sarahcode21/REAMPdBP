import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reamp/core/style/component/back.dart';

class GeneralLayout extends StatelessWidget {
  final Widget child;
  final Widget? action;
  final bool showBackButton;
  final bool padding;
  final String? title;
  final ScrollController? scrollController;
  final Widget? fab;

  const GeneralLayout({
    required this.child,
    this.showBackButton = false,
    this.padding = true,
    this.title,
    this.action,
    this.scrollController,
    this.fab,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Theme.of(context).brightness,
      ),
      child: Scaffold(
        floatingActionButton: fab,
        body: SingleChildScrollView(
          controller: scrollController,
          clipBehavior: Clip.none,
          child: SafeArea(
            child: Padding(
              padding: padding ? const EdgeInsets.symmetric(horizontal: 24.0) : EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (showBackButton) Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: padding ? EdgeInsets.zero : const EdgeInsets.symmetric(horizontal: 24.0),
                      child: const ReampBackButton(),
                    ),
                  ),
                  if (title != null || action != null) Padding(
                    padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: padding ? 0.0 : 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (title != null) Expanded(
                          child: Text(
                            title!,
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                        if (action != null) action!,
                      ],
                    ),
                  ),
                  child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
